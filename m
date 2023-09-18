Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C007A4CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjIRPkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:40:17 -0400
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054511FD0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:36:52 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-1d6cf10016cso2590650fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695051229; x=1695656029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F+MBClngMcUOr7b7qdytwU8fTtdqU1XKfB8/O+XIG6U=;
        b=wd6UaHA/gcjieEqkXUjOdXUFJQLFbqYItyqVl7Zr9DRFt0pqd+LXlyDg9SROKFde8G
         QUAdhKCnqc6MzbUUjQ/npq4oXVNXBfnlrMrJu0+KlihoH9KVtjXdQfFcsSdJisDUMek0
         t4sNbBH8QEtAQ0rZGp1Bm4u+cf/I6iOcuYMixgEtgEwLPYbE+Oezf0GnscTVXgSESKmm
         FiKP7NgOFzBQ+Z6PP6ncqqR4e4C+UTFyuh1VQaEInDH6bE22kCyDp4BI0G6TgsgC57Ac
         mPQzktVSyY76MwQaQbpeUdcHRi43RAxPAAcHtW88ig0pxBsbjEs46JHlibWt5ku1bxAa
         ixzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051229; x=1695656029;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+MBClngMcUOr7b7qdytwU8fTtdqU1XKfB8/O+XIG6U=;
        b=mNCRVkm/OUhGQlebAuIlBtlkahgSkyboP7IS+GXVYetqy77AsJm9WrU8JQvRsSs5mS
         ok6P0cPq+6PYVpSrBLeYeTVW3HlUlTTnNfWqNZ2isz7d5Lf6tH8Cd4mH/SLK6lEQzv8O
         BtlBRyPVByg+36UAUPBk5X+7k5WvZwMKBmq5SvUiwBFQOvPMkLvAt/SelrzMCVZuIjNI
         NULF0v4ggElfXp24YJlof7xLQ20xrrpwS2d87LY6ySwDPyXNhu6VEPhPnZ8KH4zr1Oh3
         91t2iC9sZhaLsaqTh6MfhdOQna1XkMvHs8pv0DagIGuV6Ph9pjKBrDGGde42PSi3m/Ew
         rfDw==
X-Gm-Message-State: AOJu0Ywk0D5Wo+aMcxL6sBpUZ4JN7GHpb2nNJiN+3Hmy2hO68SdS71g5
        UrRUK9OSAMpMi37JyMP50cvV02TDXccG26FDww==
X-Google-Smtp-Source: AGHT+IFx+dhs1ghSv6J0x7wA6J8v7WrrS+S5R+5vJdKZOMsman1WY1Cvst7HgY5gcbhc6ib4nHGqzP6AJ94fFa9fOg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a92:cc08:0:b0:34f:3625:1f7c with SMTP
 id s8-20020a92cc08000000b0034f36251f7cmr313453ilp.6.1695044049344; Mon, 18
 Sep 2023 06:34:09 -0700 (PDT)
Date:   Mon, 18 Sep 2023 13:34:08 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAM9RCGUC/6WOQQ6CMBREr0K69htaYFFX3sMQg/2/5SfSkhYbC
 eHuVhJP4GrmzWJmNpEoMiVxqTYRKXPi4AuoUyXMOHhHwFhYqFo1tZYtpCV6M6+AkTPFBG5+FT8
 BLX7InH96nynaKXgwgFjrrtUSLZIovXMky+9j89YXHjktIa7HhSy/6T9rWYKEZkCjUD+s6dTVh eCedDZhEv2+7x/V2XQM8wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695044048; l=2172;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=BYAYvIXxKCiuJsxwGROrIkadcvOKOHta7W0JbQ3yjqg=; b=I3ANWTTsDplq5xjROtlm2F8vtEaDSVUD2T6JSL9ds4y15JqL/K+3vCvuA291BuccAqEoa9+qe
 L0x+yCghW0/DGmMteuN7B/YPtb8+LCHeWHitjIQFLRm4jUKQapdjdAe
X-Mailer: b4 0.12.3
Message-ID: <20230918-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v2-1-8ae12071c138@google.com>
Subject: [PATCH v2] drm/etnaviv: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Bo YU <tsu.yubo@gmail.com>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy_pad` due to the fact that it
guarantees NUL-termination on the destination buffer whilst maintaining
the NUL-padding behavior that strncpy provides.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Bo YU <tsu.yubo@gmail.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use strscpy_pad (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v1-1-3adc2d9bfc52@google.com
---
Similar to [2] which was never picked up. Let's prefer strscpy_pad to strlcpy, though

[2]: https://lore.kernel.org/all/20190328080918.9290-1-tsu.yubo@gmail.com/
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index bafdfe49c1d8..dc9dea664a28 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -511,7 +511,7 @@ int etnaviv_pm_query_dom(struct etnaviv_gpu *gpu,
 
 	domain->id = domain->iter;
 	domain->nr_signals = dom->nr_signals;
-	strncpy(domain->name, dom->name, sizeof(domain->name));
+	strscpy_pad(domain->name, dom->name, sizeof(domain->name));
 
 	domain->iter++;
 	if (domain->iter == nr_domains)
@@ -540,7 +540,7 @@ int etnaviv_pm_query_sig(struct etnaviv_gpu *gpu,
 	sig = &dom->signal[signal->iter];
 
 	signal->id = signal->iter;
-	strncpy(signal->name, sig->name, sizeof(signal->name));
+	strscpy_pad(signal->name, sig->name, sizeof(signal->name));
 
 	signal->iter++;
 	if (signal->iter == dom->nr_signals)

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-dd095491dfde

Best regards,
--
Justin Stitt <justinstitt@google.com>

