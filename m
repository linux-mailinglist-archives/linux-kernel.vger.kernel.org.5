Return-Path: <linux-kernel+bounces-123763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9817890D73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E05C29E5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA3913E410;
	Thu, 28 Mar 2024 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T221bxNJ"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F3D13E40D;
	Thu, 28 Mar 2024 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663998; cv=none; b=lhKZFQws/cW26b/IH2CUxmy0qoXMlTfUTZIu8Do4jR+ObyLqCByQ17E2uw9Pp46fTMtv8o3eDyBX14edMfKHm7i62r8A9Ps5y+CBvbIFetLVincu2uWQP72jUqIrZ+KuLsbVKeU1YU0NQpLZB5Bu+rrQuhbFe+GYlQoHYuD/9Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663998; c=relaxed/simple;
	bh=1PzBA1ZhDSUeePpyVhsP/xK3wpo45qQhYq7BBmEtqKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ukb2FrTa0bj0+lWlEQHvpf+V+gk/4bGZnqc6asvqBFy+Ki5OcmgNf/ZoRCNECZ8xdRyOHXTmk3lt/JF1ot58XJdHVW/knztj3690ztDknczRtt4pq18fIspDEigUpZ6ojcLNbfVlTy2FsZsb+W2M+KohpveDS4AwSlUKZ+/yryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T221bxNJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34175878e30so1031811f8f.3;
        Thu, 28 Mar 2024 15:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711663995; x=1712268795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rgeFRnsuK46b4mipKZoJnQ86ybGPBmi/R5eXJ/VqwjU=;
        b=T221bxNJPZSSsr9Spty+/d38LiyI16TlNpS/PpKnNBSn7lCaJ5Pi+a8vcLOfmRcYBb
         yKDtS1+R6r3uIumg6gkw+JA+y9NeDD/IZGd023RsaIDL6HYuCLRf4+ba162VuSMKxd18
         sp7Q5zVYv8QzR94ha1yd36ae2ITdTg7hqh55WHzIvQmQPFLPZRUIacGN06pcaxtW09gy
         VS0zUjdkuc6358dMpUCxUEtoloOvqxAJVmLNVqyeSvj5U0ZXtVstYthSY89v18dIntuv
         m9wUkm+RjHNfX2R3B91zOno/hD6fABpKX1QLnISoUzMgog646LO5w5f0u9GDXZW4nU/X
         En9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663995; x=1712268795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgeFRnsuK46b4mipKZoJnQ86ybGPBmi/R5eXJ/VqwjU=;
        b=QNsJthAtcscvrBr0r9ovlj7b/+LUT0FL5LHUuQ7KRgKlaRCr3R5HRwWhV6roTnVtNA
         4PuEEbGab2Keaw4ahySspsg8KH7AVSdlWXgwcr2LXDwz0+VF+0HyPcpLa+g4Mmfwllhe
         wHEjlre2o3eQq3bD9ZuCW5wlbWxZzGzEhC0lTHLSMTMYoK8cmiisH5EMjuYa7y+5BlQD
         KvaZ3oip5PEC4HtRAw32VC4qIie2sVmQiBcjBs4H5C1HplZOr5rCMi/LAKBuglw36iCm
         fFdCpJF40SkbZxAV/koJibUjwEfU8sIx3m84Dw9vM0rHj95VH6XCtie6YgQdx4bp8PbY
         6YUA==
X-Forwarded-Encrypted: i=1; AJvYcCVUDh9Avm5ST66hM9mypDZxr/vKJY/Bxw8MES1Ie9eDs1fWjx8SbzMlEY4m1E1xsNpuKizgJwCP4NfqAhM/X2nv1ilnEl0oakYs45U2TIIobGSlqoh2fmgur14NsofFI6rsZxeuu3mz6Po=
X-Gm-Message-State: AOJu0Yw4m/j4Fi9uHGRRzJeg8r6l5UM2pm/kBGNWtoOsbTYmvD0h0OZ+
	z+Nzs8RlyfNcz2d6GavAQyZCrHK1PkGrIat+jFwRVumg/iQdNgsE
X-Google-Smtp-Source: AGHT+IG7j0PIvRS2ho64WTC9ZlQn1UU5XV7+bm1YY6W6CbLSDzZDBXi8iOrAmHVFr+wqVDakZH45TQ==
X-Received: by 2002:adf:f189:0:b0:341:b9dc:eb03 with SMTP id h9-20020adff189000000b00341b9dceb03mr256125wro.3.1711663995131;
        Thu, 28 Mar 2024 15:13:15 -0700 (PDT)
Received: from lmc-playground.localdomain ([188.25.208.244])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00414688af147sm6666778wms.20.2024.03.28.15.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:13:14 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	daniel.baluta@nxp.com,
	iuliana.prodan@nxp.com,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	laurentiu.mihalcea@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ASoC: SOF: imx: stop using the imx8_*_clocks API
Date: Fri, 29 Mar 2024 00:11:59 +0200
Message-Id: <20240328221201.24722-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The imx8_*_clocks API requires keeping track of all of the clocks used
by the IMX SOF driver via an array. This is unnecessary and doesn't
scale well. As such, remove it altogether and replace it with
devm_clk_bulk_get_all() and friends.

Laurentiu Mihalcea (2):
  ASoC: SOF: imx: drop usage of the imx8_*_clocks API
  ASoC: SOF: imx: remove imx8_*_clocks API

 sound/soc/sof/imx/imx-common.c | 24 -------------------
 sound/soc/sof/imx/imx-common.h |  9 --------
 sound/soc/sof/imx/imx8.c       | 41 ++++++++++++++-------------------
 sound/soc/sof/imx/imx8m.c      | 40 ++++++++++++++------------------
 sound/soc/sof/imx/imx8ulp.c    | 42 +++++++++++++++-------------------
 5 files changed, 53 insertions(+), 103 deletions(-)

-- 
2.34.1


