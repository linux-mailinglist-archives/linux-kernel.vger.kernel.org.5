Return-Path: <linux-kernel+bounces-135273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8571F89BE42
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BFA1C20DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA25369E1A;
	Mon,  8 Apr 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pctBE7b0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315E1E497;
	Mon,  8 Apr 2024 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576660; cv=none; b=HziM+z4ufE97Zn54gNHZs8bIx+t3UQsgzO+uVpSPUEplUYHjflV5MuI2yZFhYihFLwpHQAHfq7rTI5t5OUy2N4Kccjdghl2dWJNm0IRn/Dyoo0nU8+1cYrn1i569ehPPR4yYsssACLna0p3xS9c7fXuSwbllR1TspqJTBU8pJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576660; c=relaxed/simple;
	bh=YwMk2sIjr/LU7uq/dt950KZqYE1jbfLBSLM57hjh1mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOOrMg+jgry7IlzUPEtkFJYESetWGvt6/9gPZ4P2xwbhzTbslIxKhbBTUskB3OAbAgdtqHECEAjExPyn4QeS7X4t2eS+UjcLLIz8UP3CtZIF90zdtVAzs0WMsd4M4uB6iXapNVGX15AJi9UDD0vZIKimW0JeT9YRI3l/gcmkGRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pctBE7b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5979C433C7;
	Mon,  8 Apr 2024 11:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712576659;
	bh=YwMk2sIjr/LU7uq/dt950KZqYE1jbfLBSLM57hjh1mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pctBE7b0BI+BJkA9ICXOPNVn9+1fVk2T4OkDUXngGV6h5xWft033NVMyhyyYTEQIK
	 PHQFaTNWB2O2IHq01X3zOR0kaXc0ISBIrvl25PTnXZptDrzNEamS6DA7YWGbX/UKBe
	 QrmpeXSq/w3riyD76Dhy4pet0w037EknZaS/rEK/M+aRCcUILRv2GeO1xIUEeuwArJ
	 gl8qx1duzyyNTCkl+pqvK1CeWnQVcEMkw3aB3W+/Q+hkki81Ci74f0Y6BSK7D2IwdF
	 CxkTXWKxNGB/e1QUFSfMNbZSsfHbswwGp2SDv07uCQXn5KFSxqfFVQPQRyJ+clL5q1
	 bzFaj8H/5rvpA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rtnQ5-000000001oi-2HN3;
	Mon, 08 Apr 2024 13:44:14 +0200
Date: Mon, 8 Apr 2024 13:44:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v2] usb: typec: qcom-pmic-typec: split HPD bridge alloc
 and registration
Message-ID: <ZhPYjXjX3LcCMhyh@hovoldconsulting.com>
References: <20240408-qc-pmic-typec-hpd-split-v2-1-1704f5321b73@linaro.org>
 <ZhOYpHXz6t0fkzZ2@hovoldconsulting.com>
 <2ejpom6ykci6o7d7luwa2ao4stpm24aoyi66aoncxcqcwgidxz@gcsqvpb3s7nr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ejpom6ykci6o7d7luwa2ao4stpm24aoyi66aoncxcqcwgidxz@gcsqvpb3s7nr>

On Mon, Apr 08, 2024 at 01:49:48PM +0300, Dmitry Baryshkov wrote:
> On Mon, Apr 08, 2024 at 09:11:32AM +0200, Johan Hovold wrote:
> > On Mon, Apr 08, 2024 at 04:06:40AM +0300, Dmitry Baryshkov wrote:
> > > If a probe function returns -EPROBE_DEFER after creating another device
> > > there is a change of ending up in a probe deferral loop, (see commit
> > > fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER").
> > > 
> > > In order to prevent such probe-defer loops caused by qcom-pmic-typec
> > > driver, use the API added by Johan Hovold and move HPD bridge
> > > registration to the end of the probe function.
> > 
> > You should be more specific here: which function called after
> > qcom_pmic_typec_probe() can trigger a probe deferral?
> > 
> > I doubt that applies to tcpm->port_start() and tcpm->pdphy_start() in
> > which case the bridge should be added before those calls unless there
> > are other reasons for not doing so, which then also should be mentioned.
> > 
> > I suspect the trouble is with tcpm_register_port(), but please spell
> > that out and mention in which scenarios that function may return
> > -EPROBE_DEFER.
> 
> The probe loop comes from from tcpm_register_port(), you are right.
> However then putting bridge registration before the _start() functions
> is also incorrect as this will be prone to use-after-free errors that
> you have fixed in pmic-glink.

You obviously have to mention that in the commit message as that is a
separate change and also one that looks broken as you're now registering
resources after the device has gone "live".

So you also need to explain why you think that is safe, if it should be
done at all. You're essentially just papering over a DRM bug in the
unlikely event that probe fails.

Johan

