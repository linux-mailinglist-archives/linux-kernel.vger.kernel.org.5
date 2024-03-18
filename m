Return-Path: <linux-kernel+bounces-106065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B14087E889
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB85F2815CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B49364C0;
	Mon, 18 Mar 2024 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="uid9H/zb"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FCB2EB05
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761166; cv=none; b=GezwtXrQgdX28+cdi7Ep0E6VcESnXmaQGg3sYzSHFAroDzOnwmM3G4FhLkUcMSUKB2J64E3Cmz8PhIAMV4e2a4OH+zJt0Z628/sWSqDFJi1RXeXXUeNd2ecnwmbU4+U5bDo2VTzh60SlklMxafjsUQyirgDUHhC/GXUD94dp0dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761166; c=relaxed/simple;
	bh=MEmrvENBqeieEXTIPQlE2F8voSVpBzVnRwiUlh4OCz8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kNYvvIQUZ1LWxn3v27c8tHfNAkWWkObcuJ8fHjYrGQToMLcJSZtJq8yp7AbpQYdyzhpSrwCnsa089aQMvt/TCg9GxZs9ns3Fff1n+w//LNKXMlrUTCY8ZkoR39Vi00+uvG3Qfq54yH0nmNGsYXFF4zHkox5fvOL8UygkzOscm70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=uid9H/zb; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=S66/KalXCkob0K7VW7z58059Pe/AA7tM2tbI8/rUpdQ=;
  b=uid9H/zbSYP1dsKLD8q9q/cpRYZQh8IZWmKabUCPzOzWIbRKr6cy2cek
   C3L+LRMDLmti8WuR8C1V1PECp1BgiVAG2Tz18V9Kg0NsVbhQUV9TJtKok
   7RjZJKP90ZOeYbAP2KlyArw1aqK4cW8zMkYoby2huQ73923w6hAqGE3/i
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,134,1708383600"; 
   d="scan'208";a="157162375"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 12:25:56 +0100
Date: Mon, 18 Mar 2024 12:25:55 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Ayush Tiwari <ayushtiw0110@gmail.com>, Larry.Finger@lwfinger.net, 
    florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org, 
    linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
    outreachy@lists.linux.dev
Subject: Re: [PATCH v5] staging: greybus: Constify gb_audio_module_type
In-Reply-To: <ea44d965-e727-4fc4-86cd-b727e1e0d2be@moroto.mountain>
Message-ID: <95d1caf9-aac4-9b10-a933-63874274464@inria.fr>
References: <ZfXj1WkJ3nrYh3qL@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx> <ea44d965-e727-4fc4-86cd-b727e1e0d2be@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 18 Mar 2024, Dan Carpenter wrote:

> On Sat, Mar 16, 2024 at 11:54:21PM +0530, Ayush Tiwari wrote:
> > Constify static struct kobj_type gb_audio_module_type to prevent
> > modification of data shared across many instances(instances here
> > refer to multiple kobject instances being created, since this same
> > gb_audio_module_type structure is used as a template for all audio
> > manager module kobjs, it is effectively 'shared' across all these
> > instances), ensuring that the structure's usage is consistent and
> > predictable throughout the driver and allowing the compiler to place
> > it in read-only memory. The gb_audio_module_type structure is used
> > when initializing and adding kobj instances to the kernel's object
> > hierarchy. After adding const, any attempt to alter
> > gb_audio_module_type in the code would raise a compile-time error.
> > This enforcement ensures that the sysfs interface and operations for
> > audio modules remain stable.
> >
>
> Basically the patch is fine.  The only comments have been around the
> commit message.  And all the reviewers have said correct things...  But
> I'm still going to chime in as well.
>
> The commit message is too long for something very simple.
>
> Basically all kernel maintainers understand about constness.  There is
> sometimes trickiness around constness but in this specific case there
> isn't anything subtle or interesting.  You don't need to explain about
> constness.  Maybe you can say the word "hardenning" as an explanation.
>
> Julia asked you to write what steps you had done to ensure that the
> patch doesn't break anything.  And I was curious what she meant by that
> because I had forgotten that it would be bad if there were a cast that
> removed the const.  So the bit about "any attempt to alter
> gb_audio_module_type in the code would raise a compile-time error." is
> not true.
>
> Also we assume that you have compile tested everything so you never need
> to write that.
>
> The information which is missing from this commit message is the
> checkpatch warning.  I'm more familiar with checkpatch than a lot of
> kernel maintainers and I had forgotten that this was a checkpatch
> warning.  Please copy and paste the warning.
>
> Basically what I want in a commit message is this:
>
> "Checkpatch complains that "gb_audio_module_type" should be const as
> part of kernel hardenning.  <Copy and paste relevant bits from
> checkpatch>.  I have reviewed how this struct is used and it's never
> modified anywhere so checkpatch is correct that it can safely be
> declared as const.  Constify it."

I would still prefer to see that the structure is only passed to a certain
function, and that function only uses the structure in a certain way (fill
in the exact details).  In this case, one may just rely on the fact that
the parameter that receives the value is also declared as const, or one
could check that that const declaration is actually correct.  I think that
is what Ayush was trying to do, although in a somewhat verbose way.  This
case is a bit more complex than many others, because the structure isn't
used locally, but is passed off to some other function.

julia

