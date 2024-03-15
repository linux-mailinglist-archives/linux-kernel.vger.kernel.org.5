Return-Path: <linux-kernel+bounces-104569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B7487D010
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEC71F23A70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFCE3D577;
	Fri, 15 Mar 2024 15:20:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C953D55D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516028; cv=none; b=EG+r+sqPF1Z6zQazkGCIxDIkHwBPo1fFVHLKaURTpDVMxyuDTl6qXsuhn1OdDkHkVbDKjBXX4sUGwk94iPRmW4JqYvsjeVgieivK76o6zHTt8V24iLJfBwecoblJj2lOS8zv2Bn2r48Yfd6jpa5zrBVYZbTNxlEWzHes9oRvfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516028; c=relaxed/simple;
	bh=T/P5bk7/OtHAwC0rGVNx35zK/GRxx7+DLqSaJKl2CPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLAf2C4WTiSMEYDspD9fnTyLitP/8U/KyGCl8P+5u1Kh+cJihE0eQTQp0heeRDw+C5LpmDzw3Gp8P4qYbTq+qywf40L+srZTx2VeTXK+IqeG7ksdBmDPRD1Tw4JT3JMnCeFlCj6Xcf0/Uk2YKtriBMHL7ZTKIkqF/KPsOYDpHk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940B7C433C7;
	Fri, 15 Mar 2024 15:20:27 +0000 (UTC)
Date: Fri, 15 Mar 2024 11:22:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: John Hawley <warthog9@eaglescrag.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ktest: force $buildonly = 1 for 'make_warnings_file'
 test type
Message-ID: <20240315112240.42c725bd@gandalf.local.home>
In-Reply-To: <20240305-ktest-v1-1-5a93b8b17dba@marliere.net>
References: <20240305-ktest-v1-1-5a93b8b17dba@marliere.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 Mar 2024 14:02:47 -0300
"Ricardo B. Marliere" <ricardo@marliere.net> wrote:

> The test type "make_warnings_file" should have no mandatory configuration
> parameters other than the ones required by the "build" test type, because
> its purpose is to create a file with build warnings that may or may not be
> used by other subsequent tests. Currently, the only way to use it as a
> stand-alone test is by setting POWER_CYCLE, CONSOLE, SSH_USER,
> BUILD_TARGET, TARGET_IMAGE, REBOOT_TYPE and GRUB_MENU.

Ug, I almost forgot this patch.

> 
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  tools/testing/ktest/ktest.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index 829f5bdfd2e4..ab4bf87ba991 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -843,6 +843,7 @@ sub set_value {
>      if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
>  	$prvalue !~ /^(config_|)bisect$/ &&
>  	$prvalue !~ /^build$/ &&
> +	$prvalue !~ /^make_warnings_file/ &&

I think the above needs to be:

	$prvalue !~ /^make_warnings_file$/ &&

Can you quickly send a v2? I'll try to get it in this merge window.

Thanks,

-- Steve


>  	$buildonly) {
>  
>  	# Note if a test is something other than build, then we
> 
> ---
> base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
> change-id: 20240305-ktest-9e4452112c93
> 
> Best regards,


