Return-Path: <linux-kernel+bounces-7332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A47081A5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298AA1F2457B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F14779A;
	Wed, 20 Dec 2023 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSq/UvqC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80B46B9B;
	Wed, 20 Dec 2023 17:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDEDC433C8;
	Wed, 20 Dec 2023 17:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703091617;
	bh=O/XJ6iMVf5mhzMZzajrKO4sG0osWLp6ZgeTR5QlcSXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSq/UvqCvBNPz8ZAFp7iWXIego9AoGZpbvOGN9S7GpdvUlTITrHju9vgCvV52ctZQ
	 cd7ZUcgc1FAAiSqksXNcMsmpxECqdrcpkMeAYEBxyvzBQBVQq8VqXx6JntY54tCkgx
	 oTh/LHdhoXRo8Kka1/CqfWMVPM8mwVZKnZF7Zt4skaDgZQjmijDJp9RP3bURkAGA7O
	 7Da44Ml2vBhtqpWsBVPARcrlJ3TlNjviJB1tJAvgl01GJnEyxz4SoVtx5zB3KWK1QG
	 UBLPJSzQxDEqQG3JnvSg9FnU3gGNNlsB20Nhf1nnvqX+/4hDYnZmQKL/PKt4tdaWy1
	 N4MTt7TCtUb3g==
Date: Wed, 20 Dec 2023 22:30:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Can Guo <quic_cang@quicinc.com>, adrian.hunter@intel.com,
	beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Stanley Chu <stanley.chu@mediatek.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Peter Wang <peter.wang@mediatek.com>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
	Arthur Simchaev <Arthur.Simchaev@wdc.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: core: Let the sq_lock protect sq_tail_slot
 access
Message-ID: <20231220170001.GN3544@thinkpad>
References: <1702913550-20631-1-git-send-email-quic_cang@quicinc.com>
 <20231220145031.GI3544@thinkpad>
 <a49a0fa7-4be3-4434-bd65-1d988b0017a4@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a49a0fa7-4be3-4434-bd65-1d988b0017a4@acm.org>

On Wed, Dec 20, 2023 at 08:35:18AM -0800, Bart Van Assche wrote:
> On 12/20/23 06:50, Manivannan Sadhasivam wrote:
> > On Mon, Dec 18, 2023 at 07:32:17AM -0800, Can Guo wrote:
> > > If access sq_tail_slot without the protection from the sq_lock, race
> > > condition can have multiple SQEs copied to duplicate SQE slot(s), which can
> > > lead to multiple incredible stability issues. Fix it by moving the *dest
> > > initialization, in ufshcd_send_command(), back under protection from the
> > > sq_lock.
> > > 
> > > Fixes: 3c85f087faec ("scsi: ufs: mcq: Use pointer arithmetic in ufshcd_send_command()")
> > 
> > Cc: stable@vger.kernel.org
> 
> Hmm ... is the "Cc: stable" tag really required if a "Fixes:" tag is present?
> 

Yes it is required as I pointed out in the other thread.

- Mani

> Bart.
> 

-- 
மணிவண்ணன் சதாசிவம்

