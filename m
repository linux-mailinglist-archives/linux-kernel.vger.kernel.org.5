Return-Path: <linux-kernel+bounces-149299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DCD8A8F15
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3381C212F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD88E85268;
	Wed, 17 Apr 2024 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh8Pg/tz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272B84FB1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395055; cv=none; b=a+OsmtUifXcWneFzWxGRMByHI6hTYkAL3sa+tlhjtQRdQuSSs9dAWYjZ0ry/+luOzq8a3YYGKkPleTEgEB85QKBgQzsPyv8KdRxGOeQHAm51v1pYT5Y/oVAFZK73tAwpMdLXyr0Imd8pYzBNE/Vr5JOhZ0tmuQLuB98LdHLEHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395055; c=relaxed/simple;
	bh=SY67Ye4fXpcxOTsqzg1ms9haefD+0Alokfj1Tuddqd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crrfBiFBlOy5z/mmJHRKm9i/0FyVBcCRjAjepjMI2kAV5mxtGVAijDqxoqYNM3gvtUkQxiySDgl2BZI0gbG7/Oe0H8VrhY0tNM8X6LUr6MkxCGxBp5Xeknba9q/SWOOgRSd+LJMFI+uTA9qeYKSvmVGOoLZGXDLmZukabA1bz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh8Pg/tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5FCC072AA;
	Wed, 17 Apr 2024 23:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713395054;
	bh=SY67Ye4fXpcxOTsqzg1ms9haefD+0Alokfj1Tuddqd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gh8Pg/tzqB5Boyp4lpwLS/UpIkGzHeX9g8VbuspPSQPEISNFPLBgc1DONIA9hhU+P
	 mUnojip8XGey8tnpl7OPy1s+xhstbB/mnoy5/xLr1Z6vZwKZJgfSJ9+5gU5FVWubQg
	 Hnzh50TUvTPv3korqHoNKY1id/L4UiI2yTkzLXXtAruHaiR9ZHKonUP2HE2cRpO1p1
	 8In6ZUjZQsPI0ZV3F+hh9+XlfIJ5wfWcUmQth6uh3lfhKWfzeOkASnFzOzACeNOo/K
	 QC/n8Et2nU+T6WHjN4WTkB8tOKsbkOS+3NNSWDiyAGTjv0rwfXBLmJ9RC52p6IvX5p
	 4iAPYk28gPDVA==
Date: Thu, 18 Apr 2024 01:04:11 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 11/50] posix-cpu-timers: Handle SIGEV_NONE timers
 correctly in timer_set()
Message-ID: <ZiBVa8oSVq-GAyt1@pavilion.home>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.635345704@linutronix.de>
 <8734rrvr1p.fsf@somnus>
 <87zftzzhfv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zftzzhfv.ffs@tglx>

Le Fri, Apr 12, 2024 at 12:02:28AM +0200, Thomas Gleixner a écrit :
> On Thu, Apr 11 2024 at 17:48, Anna-Maria Behnsen wrote:
> 
> > Thomas Gleixner <tglx@linutronix.de> writes:
> >
> >> Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
> >> timer_get(), but the posix CPU timer implementation returns 1 nsec.
> >
> > copy paste error (get/set) ?
> 
> Yes.
> 
> >> Add the missing conditional.
> >>
> >> This will be cleaned up in a follow up patch.
> >
> > I'm confused. Why do you want to cleanup the conditional in a follow up
> > patch?
> 
> This patch is to fix the issue. The next one consolidates the code, but
> I can see why the "this will be ..." part of the changelog does not make
> sense.

But please keep it cut that way. FWIW it's much easier to review than the
previous take. That way we aren't missing subtle changes.

