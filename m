Return-Path: <linux-kernel+bounces-81071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2290A866FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ACA1F25F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48625F464;
	Mon, 26 Feb 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCQ3hfao"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D195DF34;
	Mon, 26 Feb 2024 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940404; cv=none; b=YMdiXEoQIjitMpNhrJeG4+unHkObkwW14O9/gp+fq7ptcpYqNjjxgeVV9YjmqlkhRHHO4HMIkrYJ7Yq3U3NgGBI9OIfw7kDPDWFtrPrj26YRIfM8IoR3h2os/C/Yz6ai4Pvyb2kVjfbsxya6BWrCGtvnlEx+c15pcZ4xhlvTqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940404; c=relaxed/simple;
	bh=8zUDVC2NMen/wlgP6Dr1a7B2WedMJqF33uyf9jialCI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=rPF8i0+HsYSGXYy5UMHY01JqmFvC6JNjEukIH+qGLaEDwec1WcA+mULKHGGzobsGvF1ot3/7qjRX3Lvi6N/WF3x2dqoDdVEwFhF1jwf2kPOgMi1IvNYTXm07hQlmviZt4+0q3tWLNNNWcY8gLa/Xt3CyPrn3BpEN3ImbP05+18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCQ3hfao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75815C433C7;
	Mon, 26 Feb 2024 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708940403;
	bh=8zUDVC2NMen/wlgP6Dr1a7B2WedMJqF33uyf9jialCI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=nCQ3hfaoxQPhGkyAqOk/8DPVp2E8K5hdvyML3x//bnINqrZ/POxSK4ZaJaGuuBx6s
	 ybbFaenIobG78QQyrVesHz/QmxplrbMPExU8gc7FeYEx6UdxTe9PoANXhGewY+DPAM
	 IqWQLm800TxEDF3pWFt2FK+52lYmV5l7QxuJUSgspyF1QlIv9G+CEZfeb34mR6zAnz
	 Br4R+WoIBaRXNOhP431f8k0kkyvCugWHh9o5Mgoyc6K21RDpgx8EbDJp9c9LLMalEB
	 x91A46KhLmsdrU90GOTThWJDUA1RK9JKiyvGHrvi5LAMmkvGP42aMQXdH99qvgmfaU
	 ghPj4a87v+qKg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 11:39:59 +0200
Message-Id: <CZEWT9D2Z7XN.36JUV0NGC2WR0@suppilovahvero>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
 Levin" <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
X-Mailer: aerc 0.15.2
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
 <CZA9ADCGOTQT.LB5XHZZVTWVH@seitikki>
 <88b75c9c-98ab-4474-8112-6a27d11a2fdf@apertussolutions.com>
 <CZCH5V83WBBV.20JR0RC1GJVJY@suppilovahvero>
 <44267c53-496d-4e41-896a-623673d938cb@apertussolutions.com>
In-Reply-To: <44267c53-496d-4e41-896a-623673d938cb@apertussolutions.com>

On Sun Feb 25, 2024 at 1:23 PM EET, Daniel P. Smith wrote:
> On 2/23/24 07:58, Jarkko Sakkinen wrote:
> > On Fri Feb 23, 2024 at 3:58 AM EET, Daniel P. Smith wrote:
> >>> Just adding here that I wish we also had a log transcript of bug, whi=
ch
> >>> is right now missing. The explanation believable enough to move forwa=
rd
> >>> but I still wish to see a log transcript.
> >>
> >> That will be forth coming.
> >=20
> > I did not respond yet to other responses that you've given in the past
> > 12'ish hours or so (just woke up) but I started to think how all this
> > great and useful information would be best kept in memory. Some of it
> > has been discussed in the past but there is lot of small details that
> > are too easily forgotten.
> >=20
> > I'd think the best "documentation" approach here would be inject the
> > spec references to the sites where locality behaviour is changed so
> > that it is easy in future cross-reference them, and least of risk
> > of having code changes that would break anything. I think this way
> > all the information that you provided is best preserved for the
> > future.
> >=20
> > Thanks a lot for great and informative responses!
>
> No problem at all.
>
> Here is a serial output[1] from a dynamic launch using Linux Secure=20
> Launch v7[2] with one additional patch[3] to dump TPM driver state.

But are this fixes for a kernel tree with [2] applied.

If the bugs do not occur in the mainline tree without the out-of-tree
feature, they are not bug fixes. They should then really be part of that
series.

BR, Jarkko

