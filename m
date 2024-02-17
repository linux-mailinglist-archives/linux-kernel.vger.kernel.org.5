Return-Path: <linux-kernel+bounces-69950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D808590B1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305ACB21AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58BD7CF12;
	Sat, 17 Feb 2024 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NDSOL2VX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E77C6D2;
	Sat, 17 Feb 2024 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708185279; cv=none; b=mZVSIwpMcChpHkrJ3vuFwF5I4IL7myz6yvjVwHPZekYiUUWjkUCzvKxTeUCG5hK+52rENM1CVo2j8vRsZN4/qYyUuz5w0HueqiRr0Z9g/4h+79XijC++JISGLbMmwGShXwjpgVcScy11n1bnDFmMUXjVF8mhmG5BwRO1FWZS57s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708185279; c=relaxed/simple;
	bh=AI0oIAcgHf1kU8VmTSbDLh+67tm7qZdcxn90MyeuyUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8KDIGDrhL8nf/zx+VQTSUuh7N2GuvHnuEuPY66Jr/X57iYPNR7FywAoNY6XruKYx93gb1QYOHxvjdD3m7bss3cnu8eiuJkeEhGI5sVEGUheCJL4qR0YDLnMBhLHIs7AG3npzzdgu25+1BFnZ50tVdWlKLEdjE+BweaW31k3eZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NDSOL2VX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9246C433F1;
	Sat, 17 Feb 2024 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708185278;
	bh=AI0oIAcgHf1kU8VmTSbDLh+67tm7qZdcxn90MyeuyUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDSOL2VX2fSLI0VVwkEpb2uSWpyMrOuWblfWsjeZlStlfoKMV+EkdueEg+1oEBZre
	 nTRvQ8YJrcSrdd0kgGFw8txsaYvqg4Kb2IK+QQiI63a8WymaDEQVSaxxMKxSiLQljA
	 9CP0RV73d+uWhOYaxZfPNbiAY84nJdjbEqksZOYM=
Date: Sat, 17 Feb 2024 16:54:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Badhri Jagan Sridharan <badhri@google.com>,
	=?iso-8859-1?Q?G=E1bor?= Stefanik <netrolller.3d@gmail.com>,
	rdbabiera@google.com, amitsd@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tpcm: Fix issues with power being removed
 during reset
Message-ID: <2024021704-reattach-wiring-7405@gregkh>
References: <20240212-usb-fix-renegade-v1-1-22c43c88d635@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212-usb-fix-renegade-v1-1-22c43c88d635@kernel.org>

On Mon, Feb 12, 2024 at 06:42:13PM +0000, Mark Brown wrote:
> Since the merge of b717dfbf73e8 ("Revert "usb: typec: tcpm: fix
> cc role at port reset"") into mainline the LibreTech Renegade
> Elite/Firefly has died during boot, the main symptom observed in testing
> is a sudden stop in console output.  Gábor Stefanik identified in review
> that the patch would cause power to be removed from devices without
> batteries (like this board), observing that while the patch is correct
> according to the spec this appears to be an oversight in the spec.
> 
> Given that the change makes previously working systems unusable let's
> revert it, there was some discussion of identifying systems that have
> alternative power and implementing the standards conforming behaviour in
> only that case.
> 
> Fixes: b717dfbf73e8 ("Revert "usb: typec: tcpm: fix cc role at port reset"")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index f7d7daa60c8d..a0978ed1a257 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4876,7 +4876,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case PORT_RESET:
>  		tcpm_reset_port(port);
> -		tcpm_set_cc(port, TYPEC_CC_OPEN);
> +		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
> +			    TYPEC_CC_RD : tcpm_rp_cc(port));
>  		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>  			       PD_T_ERROR_RECOVERY);
>  		break;
> 

Dueling reverts, fun!

:(

Badhri, can you either ack this, or submit your proposed change so as to
get this back working again?

thanks,

greg k-h

