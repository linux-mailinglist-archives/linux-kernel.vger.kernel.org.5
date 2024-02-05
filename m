Return-Path: <linux-kernel+bounces-52763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B92849C6C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D341F20F57
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0D02374E;
	Mon,  5 Feb 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfrJ7eII"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D6522EF9;
	Mon,  5 Feb 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141523; cv=none; b=TxVbKUaEFFGuEuoII+kYqmMoPHcEocotBQWRPq5A3lssy7DmSdnBZhOJhhfBjmlB+W2JNMyUQunaEeMqyxgTRu2WP0N2W7lAmOWB08glpeM3+PfkLymvR2QDdz9BeITveo5heYdpETheJFzGk7LbICbf5pISFJGDjIoMYI8lxy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141523; c=relaxed/simple;
	bh=Ewb/CNOvhV+n1Q9YjZwKRUlgQ0b1oSXCOkWG3nOyU1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbgD2Ati6Prg6hSGL39NTcXSsGc4O//KcSac0z8EaAIyxB9fHFFL3an954saCdLN4S4Q2DWTNAWgkVUhziqD6sxtp5rhelu3cF9yaQiff+CdyEuDI6Bct54AxZmnqi089lpq0Eu6hZMVe9ccBD3eCF2oUan+Z+M/GaCUPJ3Ky4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfrJ7eII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E970C433C7;
	Mon,  5 Feb 2024 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707141522;
	bh=Ewb/CNOvhV+n1Q9YjZwKRUlgQ0b1oSXCOkWG3nOyU1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfrJ7eIIIx/PnseSPnumHzQzAVUYc58ZqgJsvoS475OxAxw+Hdbo676AtILvuVFmb
	 RP+HkBnQv5SV917ESgmVdU6CbF1cwFMuTDirhK603MzCBgtq185tdZbe+/xnE9v061
	 ORb/mSMRJSiADP6UzBmXYM6J3spOxvj17qTzP+201tVURMuouzNEPtRWAdOJ90OPHA
	 YfQ0qTDcvZy5J7BJ/+G9ASZ52GnpuYNwf7dfo7Sk3oTxWtGRdsuMig9eaLCl+oKJF/
	 0elz1lxD7jGDYu79+7qq+OEdkUQHEXp8qbST+654jxWyNt+sXla76DbHEubCFsvQiP
	 JphKbifwN+8XQ==
Date: Mon, 5 Feb 2024 13:58:39 +0000
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: msm: sm8650-mdss: Add missing
 explicit "additionalProperties"
Message-ID: <20240205135839.GA3267346-robh@kernel.org>
References: <20240202222338.1652333-1-robh@kernel.org>
 <CAA8EJpooe=RsZSD_mRKH2S8NUxAEqVw_AcMyn68_AWwhovPFsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpooe=RsZSD_mRKH2S8NUxAEqVw_AcMyn68_AWwhovPFsg@mail.gmail.com>

On Sat, Feb 03, 2024 at 03:55:54AM +0100, Dmitry Baryshkov wrote:
> On Fri, 2 Feb 2024 at 23:23, Rob Herring <robh@kernel.org> wrote:
> >
> > In order to check schemas for missing additionalProperties or
> > unevaluatedProperties, cases allowing extra properties must be explicit.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Rob, if you need it for some rework, please feel free to pick it into
> your tree, otherwise I'll pick it for msm-next in the next few days.

msm-next is fine.

Rob

