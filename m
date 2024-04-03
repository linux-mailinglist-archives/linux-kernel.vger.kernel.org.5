Return-Path: <linux-kernel+bounces-129666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7306A896E45
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E981C25B07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF652146590;
	Wed,  3 Apr 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6dawHse"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6EA1419BA;
	Wed,  3 Apr 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144093; cv=none; b=f+VAi1gX16jnFFYLdMiETv4kQ+nGDcPDQrCGicO0tKQdAgykJabaZbErhRaCudQmfdqfABtrdD8v+vGLrM3jVN6WA5UroeJ3DZaLBj9AhmXlBJw6Lm19CWHPsgUf8IhFBF+cgdcMCYoIQRmGEfQM3Om4DMdDZgbgtK0xpHoxI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144093; c=relaxed/simple;
	bh=ddqmNwmKtbMZQAEP8NHIOGf4ihAZCUA7/OjrRSzy+q8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ht6cBDI97WQfHC4GvyVfliLKv5MeE4Opax6faPvk13sAIieeUMQYhS2dNuLopXYPRuArA2LvkBQi2zK/0LzUxEUExHaFr25Yw1+StOC4OSkytAvxW/8rXiounmwIYlTkybAYER1VS0FiwzM4oAYLxB56+pulj5EfD6IOU4qtqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6dawHse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD8F5C43394;
	Wed,  3 Apr 2024 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712144092;
	bh=ddqmNwmKtbMZQAEP8NHIOGf4ihAZCUA7/OjrRSzy+q8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q6dawHse5U4mUcIqqLq9WWPNXMoHky+1qpbZ7ZFOKIs0NFRqA8oDu3jeSb9xmQ4sp
	 ITyNMCPq51aHG6FNxP/gYN3Jvyl7E+YargYf37c+4V3VWtp2FIgD2ZFQ+H/yr2XA+T
	 TpfPyMfCKQW6aOJqam7x9oWS1fyuDUziNwM24fWp77ivCMEDxtF1G7gVGVOmRuHi39
	 V5S04uJ4nJ64J2uaqTOn+yGp87FTAhtzWHjuGY+SY0GAVlvUP6ElKqI8A3Y/6HJuuq
	 dv8BPuWDxERR34e1l6jpuyYxUgigljEp0XQCp/UR//9fgxS6VOcfQa4+4C8JCKXkYs
	 NzQAd79jxrISA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA7CD1288;
	Wed,  3 Apr 2024 11:34:52 +0000 (UTC)
From: Nikita Travkin via B4 Relay <devnull+nikita.trvn.ru@kernel.org>
Date: Wed, 03 Apr 2024 16:31:40 +0500
Subject: [PATCH v2 1/3] thermal: gov_power_allocator: Allow binding without
 cooling devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-gpa-no-cooling-devs-v2-1-79bdd8439449@trvn.ru>
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
In-Reply-To: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
To: Lukasz Luba <lukasz.luba@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikita Travkin <nikitos.tr@gmail.com>, Nikita Travkin <nikita@trvn.ru>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=nikita@trvn.ru;
 h=from:subject:message-id;
 bh=JaFVxsb39ZVmN8wxFQAGbfSwFLxid+4cjStl8B0OjYU=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBmDT7ayj71lCR3yKHW00w225BagKD45KIyeK4Zo
 Nv9WOzvxBmJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZg0+2gAKCRBDHOzuKBm/
 dT67D/9Y1rHlBY/kqI+8fIkl2IAGpkr14cQ8CMjProFR1nblh9duMXXVUlJ3kJPEwfyiBVueb3z
 OqcICS2efrky3ton7DizOwYuGNd6MuOHuk21GPsIJNOq2JbBehC8zwVI3ipFO0YrDkjhXPsh5MJ
 xv+ASjjpMSMjA0luUNfNrc1CdsCrf0JBNRI3vuiNU9Qcb7oCD8vaZaMj8x4oIbcyuODKQvMZudE
 fG0d6sSaXtHq7GOee+I9h9K8mQGawxUlISRmWT9/tSDkge5xb3p9ZjItxaAyvNaon2/cOZiGhUf
 +vfdhWkvpaDjhoIh7jHbuTFdWJgcHexIpqkUhw+5/rYMr+xOnecukNB6eaSfssF1NwBe+Cg4U6f
 Ai/zwuJP96XX7hgQ69twdM+VWDVKTLjzoVycefjdSLc+jsK4tIyiqOx9ZITQK+e3lVQiLmZFz+j
 Wtd5UXDRRH6Ehf1BjokhS6IhQYFegT5q6NFi3qANv8WRsP7MWVnirYkiA7pXpNe3WELEUt5lfCe
 YiREDoGWS+gUmQbCJFv3vHDI+bT6S9n2PP2dr99NZW1amGh7w6heLAfPAAmN5QI2KwOLVclObW9
 cylBhpIRiVC9a1Wo3jxsx2Ow+J4mYfY8MAJVo6pWw0MUZ428VY2MZoQmCHAJJsN4h8TRoccukM+
 lD2vYzImEvAt0DQ==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Endpoint-Received: by B4 Relay for nikita@trvn.ru/default with
 auth_id=151
X-Original-From: Nikita Travkin <nikita@trvn.ru>
Reply-To: nikita@trvn.ru

From: Nikita Travkin <nikita@trvn.ru>

IPA was recently refactored to split out memory allocation into a
separate funciton. That funciton was made to return -EINVAL if there is
zero power_actors and thus no memory to allocate. This causes IPA to
fail probing when the thermal zone has no attached cooling devices.

Since cooling devices can attach after the thermal zone is created and
the governer is attached to it, failing probe due to the lack of cooling
devices is incorrect.

Change the allocate_actors_buffer() to return success when there is no
cooling devices present.

Fixes: 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocation out of throttle()")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/thermal/gov_power_allocator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 1b17dc4c219c..ec637071ef1f 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -606,7 +606,7 @@ static int allocate_actors_buffer(struct power_allocator_params *params,
 
 	/* There might be no cooling devices yet. */
 	if (!num_actors) {
-		ret = -EINVAL;
+		ret = 0;
 		goto clean_state;
 	}
 

-- 
2.44.0



