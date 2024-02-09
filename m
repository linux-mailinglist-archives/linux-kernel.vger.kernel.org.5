Return-Path: <linux-kernel+bounces-59990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4387E84FE43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684DE1C20D30
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00D33984A;
	Fri,  9 Feb 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/s7J4Cu"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F53984B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512991; cv=none; b=MIH05wgW+J5lO/DfIoEpVtIpo9tKoCHCj1OwopWi4U8Sx6+zD2OXGn1AQ1B6SN5BdL3/EeZraFgd+NdCuUBoeX0TxqHj6k878YluUIknfIDg4SCNqkGzpBUOtDjwvQOov2cvcVZGlLeycbjfEWJwY9tKAUclmd4t23VjDOdbcW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512991; c=relaxed/simple;
	bh=TgTIkiOxuNQ1a1CE04BAe5d7kMkxUJYrxgLOnh2qf5U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EpZ2k5dXym7BYo8KSV0ZN75kd7gle5QF6zkx+zS7/MIv569qg7gil/nNcMsTdrXSjNgiWaLTdBjdojMaL9sSntVGwSWRNjYw4dYyz1lxPnS6Qij3I8W/jIptjmgZ93MFAPhDyWjfsQruqSJF/YgPQNMJ52QSgF5ix9AXmKKZiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/s7J4Cu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso1743644a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707512987; x=1708117787; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lLSVoQCZITmHHkE2ANSeJMkPS5k1b3W1O27n/YVH+Ps=;
        b=W/s7J4Cu6qRaSxwrvGoHGbMgZUnDrx1hw0y1dByjSYxcMf3/pCtszK9dy+B5opF8Fc
         +cY54Il+55NYhZfpMTltsKstUE/9CRXRPKGDHfHroCPh63JkijmGXPM36l/z+cQIdW2I
         H2JA/shkkKBjsSIbYW7k1dMPzE8wdriPdy5Ti4ejXsJMemOTvuSvYcGsjV6puoukad+H
         lHMnEvkNqL5ss5g8vBKF3jlCeUzGOsJjd9KHJdMgIiUuOMentxLi4WFZdifmnVndEDtz
         cbIEN89a7AJFHXjFdS9UFv51gs9M3IEdYZ8OM6pAYVSf2m3yc5691VOQMpRU+AkQPs0J
         l1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512987; x=1708117787;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLSVoQCZITmHHkE2ANSeJMkPS5k1b3W1O27n/YVH+Ps=;
        b=lBFc1l/Y52ELR42TlCPkoHku1vU8dBmDihYxCT0vRchvFwhWNB98pef/v4KAvQ2Tn/
         rTnodftqDnbgDOAqv8NCgcjMN9w8DCxr+TUTFPJAAtl3ja7B3rbUpWyomSw4i0EtdDav
         3i7SMAUV7LuCFOVZb0gvUCg4m0lSzIGxoGu+PmyOddQgbphDmkhXlZ51eVHFQMebn5Om
         IAPPzab78lqix6veECqVv6pzsnH48edcEVeis0pdchMME8+Ld6KZvLuoO1XWU3tQWo4f
         +72NGSRJFVEu0cIj/b9GK1N8P9RQdJhOGjFTqgfBlEcR/URxW5bzRdFaOQJUYL+1ewU1
         lSxg==
X-Gm-Message-State: AOJu0YyLPEhO2fuBTGtGIGXwM3RCo5nLZLHq44cbWyABhs7cIbxjHvLG
	XhMApzLAc18BnksnLc6+L3oRTGXGZTki0A3DObLCWJ71RvL3oo8MqFNWaoE7hs61OUaMGgcX+h0
	m
X-Google-Smtp-Source: AGHT+IFM4oxXr/uaXJDYZQFi/81N+FJqKuTPueWxqvfMRMQMmhEU0WNdeo/TQneFKeB+JMl6KZHaVg==
X-Received: by 2002:a17:906:6892:b0:a3b:9d2d:dec2 with SMTP id n18-20020a170906689200b00a3b9d2ddec2mr164242ejr.22.1707512987347;
        Fri, 09 Feb 2024 13:09:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDN4Bk0X2qND9LTPtdLq3XpGE1bm+IMiLgts4D8Kt0sFk8oNDClJLj2m1d6IlOOWeT+6PvCe3FaJ17JViG7Wao3KR7oiI5ryxkUjW41pNrzZz0P4oTVrhYtq1uy7P5OzbEM2Pfvz2iOUGijBY1eAXz9XURn5Wk2Y5O8Vtmrbb/OLH6NsDpk86F/Mz6KYKAt1+kFTafGktgBZOGQlyvmuQA9lCoQIonlKMUjmbmbZNIyU/xNvjesszg6ywMTain3R+wWasxz+qt9iBDqTVDIcXmTMvlGbMnVmWPyX+o7KGICUTiuJTrq+Vc0jCi0QY01mhUb7Fz/hatTCbV8IRp6cci8lSlUm7kuokZbRpHVk/5szhzVIXypvIS6LBoXt3mogjhge1e4W/fFwk0YX4rlSW8vBdv0zMVOpPavcGU0eT0Vfjsbax6fpphD3uqUuK9vlJSe3PGyzdNF64NbnIdkjc/k5OhMsWSTeoK5HDi3gx1DKA51V/ty17PJWyJpH3EbjO3ag==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:09:46 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 00/20] Venus cleanups
Date: Fri, 09 Feb 2024 22:09:44 +0100
Message-Id: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJiUxmUC/22Nyw6CMBBFf4XM2pq2GB6u+A/DogMDTIItmSLRE
 P7dytrlOcm9Z4dIwhThnu0gtHHk4BPYSwbd5PxIivvEYLXNdW2MWsPCnXo6iYoKjWhtUd+MgTR
 AF0mhON9NaeJf85zkIjTw+yw82sQTxzXI5wxu5mf/fm9GaeXKPq9wqErssZnZOwnXICO0x3F8A
 QJrgOS6AAAA
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=3004;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TgTIkiOxuNQ1a1CE04BAe5d7kMkxUJYrxgLOnh2qf5U=;
 b=4E4Xj8JeeWumhLvEF97sjvNXDl6V4F3zd2uZrwHnLMGfgoO7ZGRov80cFAWxL4uXFVyaVrdHd
 RVufMbhax15Baz/ovN9jGOLHIzXFqjiq2eE5BVJbof2zqgcDd71/ikd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

With the driver supporting multiple generations of hardware, some mold
has definitely grown over the code..

This series attempts to amend this situation a bit by commonizing some
code paths and fixing some bugs while at it.

Only tested on SM8250.

Definitely needs testing on:

- SDM845 with old bindings
- SDM845 with new bindings or 7180
- MSM8916
- MSM8996

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Fix "set but unused" warning in "Drop cache properties in resource struct"
- Fix modular build with "Commonize vdec_get()"
- Rebase
- Test again on 8250, since nobody else tested other platforms since the last
  submission (or at least hasn't reported that), I'm assuming nobody cares
- Needs to be tested atop [1] and similar, it's in latest -next already
- Link to v1: https://lore.kernel.org/r/20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org

[1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=d2cd22c9c384aa50c0b4530e842bd078427e6279

---
Konrad Dybcio (20):
      media: venus: pm_helpers: Only set rate of the core clock in core_clks_enable
      media: venus: pm_helpers: Rename core_clks_get to venus_clks_get
      media: venus: pm_helpers: Add kerneldoc to venus_clks_get()
      media: venus: core: Set OPP clkname in a common code path
      media: venus: pm_helpers: Kill dead code
      media: venus: pm_helpers: Move reset acquisition to common code
      media: venus: core: Constify all members of the resource struct
      media: venus: core: Deduplicate OPP genpd names
      media: venus: core: Get rid of vcodec_num
      media: venus: core: Drop cache properties in resource struct
      media: venus: core: Use GENMASK for dma_mask
      media: venus: core: Remove cp_start
      media: venus: pm_helpers: Commonize core_power
      media: venus: pm_helpers: Remove pm_ops->core_put
      media: venus: core: Define a pointer to core->res
      media: venus: pm_helpers: Simplify vcodec clock handling
      media: venus: pm_helpers: Commonize getting clocks and GenPDs
      media: venus: pm_helpers: Commonize vdec_get()
      media: venus: pm_helpers: Commonize venc_get()
      media: venus: pm_helpers: Use reset_bulk API

 drivers/media/platform/qcom/venus/core.c       | 139 ++++-------
 drivers/media/platform/qcom/venus/core.h       |  66 +++--
 drivers/media/platform/qcom/venus/firmware.c   |   3 +-
 drivers/media/platform/qcom/venus/hfi_venus.c  |  10 +-
 drivers/media/platform/qcom/venus/pm_helpers.c | 323 +++++++++----------------
 drivers/media/platform/qcom/venus/pm_helpers.h |  10 +-
 drivers/media/platform/qcom/venus/vdec.c       |   9 +-
 drivers/media/platform/qcom/venus/venc.c       |   9 +-
 8 files changed, 213 insertions(+), 356 deletions(-)
---
base-commit: 445a555e0623387fa9b94e68e61681717e70200a
change-id: 20230911-topic-mars-e60bb2269411

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


