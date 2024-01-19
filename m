Return-Path: <linux-kernel+bounces-31317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE29832C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC50C2868F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8FE54BCC;
	Fri, 19 Jan 2024 15:36:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B154BC7;
	Fri, 19 Jan 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705678594; cv=none; b=uNEJBaCfrIE0Ux69ZPVG/IqqPKXPDY3c4fgF2LYoAech2nshJGMBH7+v3wp3vQOWifOFARQXopMan0VySfjw95zcgY8lZPbXb5ZKIqEOAslgg9Y1MGbwOH3A6DDyV93m3utrU2xw4Eldy/+Balia/4Ec4uYw0GK5+CSTSIY9y2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705678594; c=relaxed/simple;
	bh=mdLArEAx2++hnsF4nRXH6+e4vKM3ueZvivxFppef9Do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIhk8hCEJAuV46jBKipzXCUOA83nkpSAgV7kT2FjTBTUI0taQrhDxqj9dpi8SHETjaGx1B1YPmDWvnjLarU+6wexXHJYR7Psxlo8k7oDroHNN7PjtlX4yID3uvulik0zCVNgP0eCm/KDozDpn/mRVeNBxCGKPM9E7vkVyIHicJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29257C433C7;
	Fri, 19 Jan 2024 15:36:33 +0000 (UTC)
Date: Fri, 19 Jan 2024 10:37:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ring-buffer: Simplify reservation with try_cmpxchg()
 loop
Message-ID: <20240119103754.154dc009@gandalf.local.home>
In-Reply-To: <504085e9-bf91-4948-a158-abae5dcb276a@efficios.com>
References: <20240118181206.4977da2f@gandalf.local.home>
	<504085e9-bf91-4948-a158-abae5dcb276a@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jan 2024 09:40:27 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-01-18 18:12, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >=20
> > Instead of using local_add_return() to reserve the ring buffer data,
> > Mathieu Desnoyers suggested using local_cmpxchg(). This would simplify =
the
> > reservation with the time keeping code. =20
>=20
> I admire the effort of trying to simplify the Ftrace ring buffer by bring=
ing
> over ideas that worked well for LTTng. :-) As reviewer of the tracing sub=
system,
> I certainly welcome the simplifications.
>=20

The idea itself wasn't new. It was you convincing me that
local_add_return() is no faster than local_cmpxchg(). As I would have done
it this way from the start if I wasn't dead set against adding any new
cmpxchg() in the fast path.

Testing showed that local_add_return() is pretty much just as bad, so the
added complexity to avoid just slapping in a cmpxchg() was useless.

> > Although, it does not get rid of the double time stamps (before_stamp a=
nd
> > write_stamp), using cmpxchg() does get rid of the more complex case when
> > an interrupting event occurs between getting the timestamps and reservi=
ng
> > the data, as when that happens, it just tries again instead of dealing
> > with it. =20
>=20
> I understand that the reason why you need the before/after stamps and the=
ir
> associated complexity is because the Ftrace ring buffer ABI encodes event
> timestamps as delta from the previous event within the buffer as a mean of
> compressing the timestamp fields. If the delta cannot be represented in a
> given number of bits, then it inserts a 64-bit timestamp (not sure if that
> one is absolute or a delta from previous event).

There's both. An extended timestamp, which is added when the delta is too
big, and that too is just a delta from the previous event. And there is the
absolute timestamp as well. I could always just use the absolute one. That
event came much later.

>=20
> This timestamp encoding as delta between events introduce a strong
> inter-dependency between consecutive (nested) events, and is the reason
> why you are stuck with all this timestamp before/after complexity.
>=20
> The Common Trace Format specifies (and LTTng implements) a different way
> to achieve the same ring buffer space-savings achieved with timestamp del=
tas
> while keeping the timestamps semantically absolute from a given reference,
> hence without all the before/after timestamp complexity. You can see the
> clock value decoding procedure in the CTF2 SPEC RC9 [1] document. The bas=
ic

That points to this:

---------------------8<-------------------------
6.3. Clock value update procedure
To update DEF_CLK_VAL from an unsigned integer field F having the unsigned =
integer value V and the class C:

Let L be an unsigned integer initialized to, depending on the type property=
 of C:

"fixed-length-unsigned-integer"
The value of the length property of C.

"variable-length-unsigned-integer"
S =C3=977, where S is the number of bytes which F occupies with the data st=
ream.

Let MASK be an unsigned integer initialized to 2L =E2=88=92 1.

Let H be an unsigned integer initialized to DEF_CLK_VAL & ~MASK, where =E2=
=80=9C&=E2=80=9D is the bitwise AND operator and =E2=80=9C~=E2=80=9D is the=
 bitwise NOT operator.

Let CUR be an unsigned integer initialized to DEF_CLK_VAL & MASK, where =E2=
=80=9C&=E2=80=9D is the bitwise AND operator.

Set DEF_CLK_VAL to:

If V =E2=89=A5 CUR
H + V

Else
H + MASK + 1 + V
--------------------->8-------------------------

There's a lot of missing context there, so I don't see how it relates.


> idea on the producer side is to record the low-order bits of the current
> timestamp in the event header (truncating the higher order bits), and
> fall back on a full 64-bit value if the number of low-order bits overflows
> from the previous timestamp is more than 1, or if it is impossible to fig=
ure
> out precisely the timestamp of the previous event due to a race. This ach=
ieves
> the same space savings as delta timestamp encoding without introducing the
> strong event inter-dependency.

So when an overflow happens, you just insert a timestamp, and then events
after that is based on that?

>=20
> The fact that Ftrace exposes this ring buffer binary layout as a user-spa=
ce
> ABI makes it tricky to move to the Common Trace Format timestamp encoding.
> There are clearly huge simplifications that could be made by moving to th=
is
> scheme though. Is there any way to introduce a different timestamp encodi=
ng
> scheme as an extension to the Ftrace ring buffer ABI ? This would allow u=
s to
> introduce this simpler scheme and gradually phase out the more complex de=
lta
> encoding when no users are left.

I'm not sure if there's a path forward. The infrastructure can easily swap
in and out a new implementation. That is, there's not much dependency on
the way the ring buffer works outside the ring buffer itself.

If we were to change the layout, it would likely require a new interface
file to read. The trace_pipe_raw is the only file that exposes the current
ring buffer. We could create a trace_out_raw or some other named file that
has a completely different API and it wouldn't break any existing API.

Although, if we want to change the "default" way, it may need some other
knobs or something, which wouldn't be hard.

Now I have to ask, what's the motivation for this. The code isn't that
complex anymore. Yes it still has the before/after timestamps, but the
most complexity in that code was due to what happens in the race of
updating the reserved data. But that's no longer the case with the
cmpxchg(). If you look at this patch, that entire else statement was
deleted. And that deleted code was what made me sick to my stomach ;-)
Good riddance!

-- Steve

