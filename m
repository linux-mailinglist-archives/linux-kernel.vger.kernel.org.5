Return-Path: <linux-kernel+bounces-50036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72155847385
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBB228DB98
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD55E1468FC;
	Fri,  2 Feb 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JRAQ/uqa"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9733914198F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888501; cv=none; b=qIU/CnnwljgTwpsN4V1ZQeIqr5okVyQmWwsO8ldo9bGyOTfWkBaxjWnpPRzWPWGjHOhKLjnjWD+nOx4zLbyhCP2hN1Gyd++srxyzXqQ8k2iPYcKbHs2GMSTcOl6/ssgVnyFbrb3prQwbihvgcqZ8YALbf2ibZA1UH6op/0QBi2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888501; c=relaxed/simple;
	bh=eJrK77JbCOPtMQySye6xFo6DxvsSg0ZFdJ/9vChdHvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ikf236lEzsCem6ldoJnDrutZZ5nWa6FsGL+EtfzkoI9wOaNiHYDmFoQ+VATk6yoJw0LbpmMjfp2wu4/V9Ck1GPHKpc8ABVZf3nUHaXnkKOdU6tTiQvTm3TwrKLZOn1veiNyMhiN3ha9tA2V1srVZhF8/wOlUEjjRLm36h5DvcLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JRAQ/uqa; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a34c5ca2537so321379666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706888498; x=1707493298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9GFyYMnxvYJ3CC02VMRtntZh2qFQxlE6u4r2ee4s6k=;
        b=JRAQ/uqaOyz6yCxNY/yONnT2shr9LiBxALSyyjhv8pr3RwSv/COC5jrmXC3kmRWVMH
         w34hIeIfIPKtvCoC4lG1N9YzJG0T+3dh7GhhvyuUw0jN53oXMC/Rgk8DxQc3bMXIjfhf
         tD2e8N3njtADuFACOwLarHNtG8cp1W4SYMe3gUAPDwxHEgI0Vp9NFqD12UkQZJntbH6t
         A3Xcq+K1GGB9M04keO2PJglxlVcM1EEG5fk6fZqMuOt2MBerebJb9QM6n/gTgzGOLb84
         7G0lekGzhJ1tOrErIlTDz/j/LNlx+LC5ecWscnFwt5tH2PLuSPqAb7t5h59V0ZnRvpAi
         pWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706888498; x=1707493298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9GFyYMnxvYJ3CC02VMRtntZh2qFQxlE6u4r2ee4s6k=;
        b=lNhVSmZGAPrecq5sWG9uC2RqXkrKa9L9cAJrYMZ4eGrBkT8TlVRNnikyhgIl6VCHMb
         Lz/1HLKNfLDnK73JCa9BBKWqieQEXnpoq7xsEL7aWDwnPSpqIVxpVcLwF5eUOSOTC6pq
         lwasKzlpwbRpJmsaPeys/DWnJD/SbK5m1NRTgbB/7geyMQXBda82vUeIAk6Xkkeibnmp
         ZhNVFCcPVSeibbnRG9/Q2raKot4sV/iXFHSBugEYolbx0+oFwEvZeUwVqeb/Aft5mTPA
         yxuTS6ewcqBfHG2N0Qwqb6f30v085PbRjP46eE64DQu7pZi9vTeUTj3Iis/Qv8HQbQlZ
         Bdug==
X-Gm-Message-State: AOJu0Yztkgvuji+7nyRfP2lmDaGTUzf8KoGd2FwC3k/OHXdMPICCNAvq
	ID0qIvAO0cx2Qgsz0IuwGJ/tey8li1/IHfGC/24gLb2vCJAunj1jIJpc0Nb7dIk=
X-Google-Smtp-Source: AGHT+IHOVJOP0VpQcVk25AB8u737nThh3XuWqp65dG0kE/mgS+wyNCIL1lVGJyBNR1Jm01ocDs/fKA==
X-Received: by 2002:a17:906:31cd:b0:a37:1f87:33b0 with SMTP id f13-20020a17090631cd00b00a371f8733b0mr816000ejf.13.1706888497815;
        Fri, 02 Feb 2024 07:41:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU54/Xv9yBYsJVhurd9b8NvezMMQWn48AVlvITIq4IowJg+essYYhY9hiRygevu1tYmpTvN6J5p5w7/cAg7LVWcZCDtugFmyoF1n6UDzO125nyA1CQN1VmSbLO0TVAYD9IM7m8qXMvg3qIei5z50ulwK/3Iz7aeDdzDsLneYjBosPAPSCorxZJVTOSv4ScFS89Bdme1nzsHwH+JLvPpSxkE8+yulMlt6qzMCab0LZofgF2k1Vq0Xx2rQ7t637l1Ni7UOD0BAUNFuvyFOnwcbRBlPe1hucyp/teLwGsWQkgwLe+8+5M4
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id cu9-20020a170906ba8900b00a37116e2885sm624819ejd.84.2024.02.02.07.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:41:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] ASoC: codecs: qcom: tx-macro: minor cleanups
Date: Fri,  2 Feb 2024 16:41:31 +0100
Message-Id: <20240202154134.66967-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Few minor cleanups.  The series will conflict with my series:
https://lore.kernel.org/alsa-devel/20240129143534.109196-1-krzysztof.kozlowski@linaro.org/T/#t

Depending what will come in first, I will rebase the other patchset.

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  ASoC: codecs: tx-macro: Drop unimplemented DMIC clock divider
  ASoC: codecs: tx-macro: Mark AMIC control registers as volatile
  ASoC: codecs: tx-macro: Simplify setting AMIC control

 sound/soc/codecs/lpass-tx-macro.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.34.1


