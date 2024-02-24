Return-Path: <linux-kernel+bounces-79591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5769086248F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB311C21709
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912C42941B;
	Sat, 24 Feb 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uW6W803B"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256761BC3B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774856; cv=none; b=fBKDpF0+BQu4StLsEQjKLNIWmVzZfH9NAUKXQG4csovtKmVzdO2EKxdZiG7/qDlWT86QjAlIsDrieT76SWLIDYk7v5h+3BO7+14k2apJZwT2bH3Q/1qCIrKplG660IMPaMk7bw01MD5kEkolQfYMue5ijmHKraZfV282Mz5hOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774856; c=relaxed/simple;
	bh=mr9b5yqtv1KJWqxG14tl0ErjjIEEor4QF+H/kFujzhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=skUx20nhTNbqiMLoKeAgEnZFHhPP/pnWiDap0telnHySCXuOnRC85EpVbPNMDYLSJo6R4x8lznPHJubS2/VZM4Ld1w9ukubFsULLk/fuBZ98CnHqL/VyYyqgVyCk1m2DF/BJiLCwwTIZB716QuA9QdSLXf/KJgGt5OamXwNrMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uW6W803B; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a293f2280c7so201445966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708774853; x=1709379653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKhgM2A9LMJY/doRx/LRPm3OQKVUAKXhlsOg/UwVdas=;
        b=uW6W803BUo8rQQCIAVtOL/9lf6RVMyRnoiyGfv5bhVYbREC9Z6q+QT1r5X9rpffSUk
         lt564RaO0ZIF6smjw49fRFcdTpDycowr7Row4WxqpT4s0H20NWCG/lyZCY7QX9gN2Eyr
         j0ATPfGp9HKbIvtXaM7ocDGZTtutozso1AXHimVeGkEgdIeAxLjaKkp+OSozQpUcgk8i
         DOmQvfIGp0m1cs1NSRGtIDhs7rwCDnH86mgVO+p4c5lwr+x+3VsVnUNZqF3kRcqvMr5c
         KQ+nF/w3xYrYUOxVzsTwAB6Va6DcUCHQYoYScKjsqU4b5xdtfcbB0rxmwLz51MWrECiN
         Xoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708774853; x=1709379653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKhgM2A9LMJY/doRx/LRPm3OQKVUAKXhlsOg/UwVdas=;
        b=j7MR214xCHNeoYg6uwe/FQQc4IFDBnEztaevxufHT/itbcmNCxYRZqAHxxH+NRFMD6
         2JoHY5xbsRKiRiGbXcbVYRnaG+CuHSgzH5FEs/VecVzCdBu2yXshUpryBcxbA1pso6Ja
         7ZOk6FhO8NcihFuEXZplq6vnNiwhGCXGuJwMQmxVxnr829qZckfIiAZ9LtB02ueAd+NB
         janQ6yuf2JabignizeNGVC7NqpJVHtA4MAbEh9TOprw6/KAOjqMFsR0LzipVmldWziKh
         moRqhO0BSpvznoc4EAaR2/z2rP3PLnIF78d6dlKiqQmiXPP1rO4NnrRl0qulimOwaPP4
         z+7Q==
X-Gm-Message-State: AOJu0YwoVn6HD6ig9lAwvdcrU5UjoBjzYY0KFl7f/r3wMlqgddlyX+S+
	IqyX0DtXsdOJVbppHWATie6TXE6A1mB3ft3u6rWLWN+JJ317BDMNqqzqHRKG70o=
X-Google-Smtp-Source: AGHT+IGzYesYf0TNx4yd2E3rOjQRZaMgok4eFUkpYEnfm6isUAf1Mz39lE+cEL+9QD1ywb0i0TkwvA==
X-Received: by 2002:a17:906:318d:b0:a40:4711:da21 with SMTP id 13-20020a170906318d00b00a404711da21mr1350863ejy.37.1708774852935;
        Sat, 24 Feb 2024 03:40:52 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709063e0800b00a412d3d509fsm509335eji.181.2024.02.24.03.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:40:52 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/1] nvmem: fixes for v6.8
Date: Sat, 24 Feb 2024 11:40:22 +0000
Message-Id: <20240224114023.85535-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=320; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=1VpGEs3YOg1HjaDj+L9dZn4VNAsH6a3WmzjHBFiMmS0=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dWjalHr6ajCt+2mwj0e+t80uuPy/tLmInNlR MV1I67wWvOJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnVowAKCRB6of1ZxzRV NxcSB/433DLUNofFWm3vL7f3JVWV057eHJWu45jJkQPG4fM5TOY1TjP9N0MDnH3N2Otub7FZAB9 tepdTZeGiqDoNxZXtUgQb50n+CjTgcARcRbeJHFxEcNeGFsExWs2kfVzuwiej1ui761M+scLrRo K/EKGpLE/eoT2T5w5HnIVKVmYayJmf7NT1USLJFmWzGb880eiazhP3rEiqy7ihwZdpq8xlNyNXp rFqFYJWtTTq8m1X6tIUgwA1LCLVc5EZT6Ip+GSn+a89tbJeolae3s29RiY+96zjXZl5UXgzi2TF 0rviw+VyluInwG4z+wfeOfdH6ZSJgoub2NUubp+/61MyGl7j
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Here are one fix in nvmem for 6.8, Could you queue
these for next possible rc.

Thanks,
Srini

Jerome Brunet (1):
  nvmem: meson-efuse: fix function pointer type mismatch

 drivers/nvmem/meson-efuse.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

-- 
2.25.1


