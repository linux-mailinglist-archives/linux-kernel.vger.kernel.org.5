Return-Path: <linux-kernel+bounces-120591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9393A88D9CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F6CB22EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7CA374C6;
	Wed, 27 Mar 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OqvcAHOs"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86414125C9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530823; cv=none; b=dfo58S3CXhUDjnq0fNCIvg3CamQV9xsJU8Wj/ip0MdqdT8BguJq1O2t8DSpZCvtsbdWcQ/BRIIpE/aLUDUPZoB3Q0Q4iTgJC8TWweNd0R5AcUxjLD9/FePD3kfTHjU9LPx4Kk483Kb0LLNrEic/iQblON6TI08Wra6Np9V0sTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530823; c=relaxed/simple;
	bh=PjDcWxabCM5zhojYO64Rjs9rcFKOjg+P9yQ2hF4+9bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BM+TA6mixTcGAgYQWAJt5LOy09oQWNbqDigKKUWMuBDVpSiJgTKMHa85Icsd7looc7uESefOqc65Fn293FqgkV8OWmpGDU6auvtmOWjEJs/m0ad0eqK2m0S31TnewEktvP6BXbaMoik4pmkpoTKmekxo9YE9uhIGCT1OIbHKcmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OqvcAHOs; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22a5df0f789so714334fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711530820; x=1712135620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxElVZwgDSK1YSb8hGRkSJE7Hq+zmgPYXh8LPg2gT3Q=;
        b=OqvcAHOsm5DHICqRPV1TBh7v9tcWsaLNgTuW2k5xXnDrPPlK/Ihh04JzxtK6RlXupR
         NPm6zR1HOvT+4ZAS4MW6TzgtKwuSWPdUda7xtzPqbyLqYmrFpyoqLeb5XLD4wWlER4M+
         yy9obZHcHNBQmoo/jPNQSWJK/MHLFOiSbVOdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711530820; x=1712135620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxElVZwgDSK1YSb8hGRkSJE7Hq+zmgPYXh8LPg2gT3Q=;
        b=j1BgtfyPj+P7+LFm6O8BMCB9n6+wkAYGtA8x5b8EPDXhdpYReC17m9/71MKHj/YOTL
         IWJJOTFT0stzxvubQAPrEJ4NVQbjGxqvAYjPq+nRGOLjV/Y+bGj0hd+VohojjWpVpmod
         AUhrmZJdy7KlBnjrG3/fH1RALudsOe9DvzyZM96NzpRkDNqRiG+K88DYVdJB5hiXrNjY
         1SD1Cfsag2agnS8TNKzVLpW2ztpdg+pxQFQ6b9aItnilsK2yf3WEDqmxBuMGhx6/EBC2
         b+IQbaR1k47Q7041PbN4kGpSE4eFHOxFAc+DQQBJzMifjV6PHIozHXp5hRubP25fkL6Z
         KMrA==
X-Forwarded-Encrypted: i=1; AJvYcCWnsVMxVOV8exIO5wpJ46er1QUeKha2RLsFqxChfM11E/iVc9BsztgBRYJrCLhNBoy1sVRCSRkxuAaP6pbPBzX7l4k/gQ9sF0OKhp1U
X-Gm-Message-State: AOJu0Yw+m9DFdYxDt3dSzJIBFUtoYZQradJhOWvrVBueZgtq4MKeYHw+
	ialfmYV1BJUEXjqT4mJfpdUPNBQAWlpicBH1S7sEC90YxyRNm4wIIqwwqa9c8A==
X-Google-Smtp-Source: AGHT+IEb932ORwMZAWuJMDZYxzAxef8XwPiw/kk7kOZAgwvVteC2Tlm4yt0lNUvQ8BGf1TisMGWnlQ==
X-Received: by 2002:a05:6870:1c8:b0:229:f61d:7e52 with SMTP id n8-20020a05687001c800b00229f61d7e52mr6040680oad.34.1711530820771;
        Wed, 27 Mar 2024 02:13:40 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74c2:3606:170b:52f3])
        by smtp.gmail.com with ESMTPSA id fa31-20020a056a002d1f00b006e69cb93585sm7342911pfb.83.2024.03.27.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 02:13:40 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pinctrl: mediatek: paris: More pin config cleanups
Date: Wed, 27 Mar 2024 17:13:32 +0800
Message-ID: <20240327091336.3434141-1-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here are a couple more pin config cleanups for the MediaTek paris
pinctrl driver library.

Patch 1 fixes readback of PIN_CONFIG_INPUT_SCHMITT_ENABLE. The function
was passing back the disabled state incorrectly.

Patch 2 reworks support for PIN_CONFIG_{INPUT,OUTPUT}_ENABLE, following
discussions on the bcm2835/bcm2711 pinctrl drivers [1]. The driver is
made to follow the definitions of each option as described in the DT
bindings and pinctrl core.

Please have a look and merge if possible.


Thanks
ChenYu

[1] https://lore.kernel.org/linux-arm-kernel/CAGb2v66XpjvDnTpi2=SPbeAPf844FLCai6YFwvVqvmF9z4Mj=A@mail.gmail.com/

Chen-Yu Tsai (2):
  pinctrl: mediatek: paris: Fix PIN_CONFIG_INPUT_SCHMITT_ENABLE readback
  pinctrl: mediatek: paris: Rework support for
    PIN_CONFIG_{INPUT,OUTPUT}_ENABLE

 drivers/pinctrl/mediatek/pinctrl-paris.c | 40 ++++++++----------------
 1 file changed, 13 insertions(+), 27 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog


