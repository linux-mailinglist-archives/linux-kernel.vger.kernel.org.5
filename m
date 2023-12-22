Return-Path: <linux-kernel+bounces-9854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE981CC64
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916462863FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C665C241E9;
	Fri, 22 Dec 2023 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlDxRxG5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED423765;
	Fri, 22 Dec 2023 15:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B0AC433C7;
	Fri, 22 Dec 2023 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703260162;
	bh=Ag0mzWcsnW1g3n91UWrk0/4qwvTZgSOiJlVaZYR4sxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VlDxRxG5wy4qKpfb3iXAPj2Uc6r15R51pEALVoOguck+w7rxTUgs1Xgby3rJZNH4X
	 aie0n5cySZhL8SQ0JI70Zn4Jeexb+FDiM52jtiZqhjvg6LvIDcmcg29wi4eem6TTdD
	 P50+IEjlxIsiOcm9fcWgSSzDH7PJUBusRPKGFbWNr4gISpI+/bmuMHTreF5WTcVIrm
	 pIrpZVrkAQdSsebQ9W90K6cHkkF0JHyjU3EXoteXRH2y3Ei+iPCWckqgI6NaSPbvro
	 vXNQTvmHG14Uw6zVmpqGD25Rg4sL+c0jd52jqN2lvzDHXbQiC0xPq8l2pznqs+GUg2
	 HoSzyldwEOq+w==
Date: Fri, 22 Dec 2023 21:19:18 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Can Guo <quic_cang@quicinc.com>
Cc: bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com,
	beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	"open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 09/10] phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550
 UFS HS-G4 PHY Settings
Message-ID: <ZYWv_rmgLN3NuyY2@matsya>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
 <1701520577-31163-10-git-send-email-quic_cang@quicinc.com>
 <ZYRyJU9klhZzLdni@matsya>
 <ad95e193-1216-46ae-9f7d-2967a24d7a12@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad95e193-1216-46ae-9f7d-2967a24d7a12@quicinc.com>

On 22-12-23, 15:41, Can Guo wrote:
> Hi Vinod,
> 
> On 12/22/2023 1:13 AM, Vinod Koul wrote:
> > On 02-12-23, 04:36, Can Guo wrote:
> > > The registers, which are being touched in current SM8550 UFS PHY settings,
> > > and the values being programmed are mainly the ones working for HS-G4 mode,
> > > meanwhile, there are also a few ones somehow taken from HS-G5 PHY settings.
> > > However, even consider HS-G4 mode only, some of them are incorrect and some
> > > are missing. Rectify the HS-G4 PHY settings by strictly aligning with the
> > > SM8550 UFS PHY Hardware Programming Guide suggested HS-G4 PHY settings.
> > 
> > This fails for me, as I have picked Abels offset series, can you please
> > rebase these two patches and send
> > 
> In v8, I rebased the two changes to linux-next. Is the ask there to rebase
> the two changes to phy/next?

Yes these two failed to apply for me, pls rebase and post

-- 
~Vinod

