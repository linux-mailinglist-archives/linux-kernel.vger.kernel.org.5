Return-Path: <linux-kernel+bounces-52067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821518493B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B529D1C2272E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA8AC121;
	Mon,  5 Feb 2024 06:09:32 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4D8BE4C;
	Mon,  5 Feb 2024 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707113371; cv=none; b=NIpGl/8vKD2mYcteKodjlsG5ZHMAKnW2o7ZP5eo+L7OYclD3RmLinnOYOWRmBpvmx0OXOyIGOM/Tfaldx3VX5D1mP7lsiFBoh7izvDhcGMortUZJM7aHHAc7UiwGysNsPL7twJ8db0u15Os6HHaZkxwBRG/RBNohijMzdPOhnrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707113371; c=relaxed/simple;
	bh=O6lE1j6DLw2hNNPADG3UruIJV8j82U4fDFAtxuxNxAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pu5PaVCJo1KPJXAhgF4IChrD6lSnp7eZNR/ciApPPW6pWA6s2iYgL49hkL2RWoD5Mr5puKhCd72VAY1NnPWJr6EQH8DUADj6ZEG/1PMh48Gi1z16uVW3AHKD7IgfQCvLFSRvj12EhfSKOBaD3fQrma2KER03iVp+2URYE7GNTqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxifCWe8Bl58kKAA--.30566S3;
	Mon, 05 Feb 2024 14:09:26 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHs+Ve8BluusvAA--.49177S2;
	Mon, 05 Feb 2024 14:09:25 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>
Cc: kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Update kasan docs and tests
Date: Mon,  5 Feb 2024 14:09:20 +0800
Message-ID: <20240205060925.15594-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxHs+Ve8BluusvAA--.49177S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
	I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
	jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20x
	vY0x0EwIxGrwCF54CYxVAaw2AFwI0_Jrv_JF1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
	O2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
	YxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

Tiezhu Yang (2):
  kasan: docs: Update descriptions about test file and module
  kasan: Rename test_kasan_module_init to kasan_test_module_init

 Documentation/dev-tools/kasan.rst             | 20 +++++++++----------
 .../translations/zh_CN/dev-tools/kasan.rst    | 20 +++++++++----------
 .../translations/zh_TW/dev-tools/kasan.rst    | 20 +++++++++----------
 mm/kasan/kasan_test_module.c                  |  4 ++--
 4 files changed, 32 insertions(+), 32 deletions(-)

-- 
2.42.0


