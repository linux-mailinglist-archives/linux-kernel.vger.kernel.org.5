Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED087EDF00
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345073AbjKPKzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345033AbjKPKzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:55:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE271AE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:55:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28307847ea4so482824a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700132102; x=1700736902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW10PJvtiu66gKZ9OhgFw07dy2Cz+r4ALsKXP/AIek0=;
        b=PUvslIBjqg9XwoX4e62ngw0xw/kZijt22rk4zSn6vdX/ZErWw108S6CfxcfBqXZ0DH
         wiTFb95ISN9RIah3MbcMvkEBCWjP6clb7ua7cumEhIkfXNUcpoHAbEpznNUxCnFj6HLs
         FHpn9WtYsJGnBcfyuUQXGomUcCGOLL0efm3XK4/zExNfiVXFt9EtazxBEMxxiE5kec+d
         lcV21CI5DNBdlaqBmiJQR1k9SU3oSDmmYZVyNCRy86Ta1qVNAFehP2iNgLEhuMSLyAoM
         OAVsdDmeh+TthZzHR3fBrFzem3HueJAxyAEFtPSE/Cp11EhTaBOmMSGUqk0JE2MxeWjl
         mmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700132102; x=1700736902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zW10PJvtiu66gKZ9OhgFw07dy2Cz+r4ALsKXP/AIek0=;
        b=XlHVpVGQFPGzFg/TCIg3LGs9S8LxyvyBRpQUv6sW7u4680mh1qhZXls17l3iozlpw7
         GCgotBcMF/OciYzMRMLdIx0N2Q1JYCWQI3WLyhHftIjROkDhxmQaW7ugTujEf49jxcSc
         U/4xoHybsPyolCXYX1IunMztcHo4lQJMNJ3Xua6qAw//URpPYZknlnRVeETOoBxub0eV
         pAwJ58s0tNUO+3iOWfMIQjJ8S86kfzHQ1mW5J7aZJ0E4T2nCJ2CPUz6N5rkkbgS4fWEA
         CXMxjLDOxMqH3o5OLdEAYSx+CwsWXLh8GEsVMIHeVNjaz0FffbnjC0wwmK/dQTuCFfcp
         4TYg==
X-Gm-Message-State: AOJu0Yy5rpzJQpMEM/c26KSW4qJ9pfGxl6M2/GDFrn3Tx7cEw0fzh601
        7z/tuQ14kNbVdWDg53ZxzrY=
X-Google-Smtp-Source: AGHT+IE+9n16wXsjuyYblqV8Z+rx0CcW86vtPF5IBfATuumd9kOjnrGui3S/jVhwXwyEPi5iQgD2fg==
X-Received: by 2002:a17:90b:3e89:b0:280:2609:6d51 with SMTP id rj9-20020a17090b3e8900b0028026096d51mr12400670pjb.18.1700132102426;
        Thu, 16 Nov 2023 02:55:02 -0800 (PST)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (111-255-239-171.dynamic-ip.hinet.net. [111.255.239.171])
        by smtp.gmail.com with ESMTPSA id mf11-20020a17090b184b00b002802a080d1dsm1325064pjb.16.2023.11.16.02.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:55:02 -0800 (PST)
From:   Yiwei Lin <s921975628@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wuyun.abel@bytedance.com, linux-kernel@vger.kernel.org,
        s921975628@gmail.com
Subject: [PATCH 1/1] sched/fair: Update min_vruntime in more relaxed way
Date:   Thu, 16 Nov 2023 18:54:25 +0800
Message-Id: <20231116105425.84773-2-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116105425.84773-1-s921975628@gmail.com>
References: <20231116105425.84773-1-s921975628@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As EEVDF adopts lag-based solution which is irrespective of
min_vruntime like CFS before, min_vruntime is only used as
an offset to avoid overflow on evaluation of avg_vruntime now.
Rely on the fact we will always update_curr() before change
to cfs_rq, it seems to make sense if we just
update_min_vruntime() with update_curr() to reduce the cost.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 kernel/sched/fair.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 07f555857..5c40adfae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3815,17 +3815,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		update_load_add(&cfs_rq->load, se->load.weight);
-		if (!curr) {
-			/*
-			 * The entity's vruntime has been adjusted, so let's check
-			 * whether the rq-wide min_vruntime needs updated too. Since
-			 * the calculations above require stable min_vruntime rather
-			 * than up-to-date one, we do the update at the end of the
-			 * reweight process.
-			 */
+		if (!curr)
 			__enqueue_entity(cfs_rq, se);
-			update_min_vruntime(cfs_rq);
-		}
 	}
 }
 
@@ -5347,15 +5338,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	update_cfs_group(se);
 
-	/*
-	 * Now advance min_vruntime if @se was the entity holding it back,
-	 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
-	 * put back on, and if we advance min_vruntime, we'll be placed back
-	 * further than we started -- ie. we'll be penalized.
-	 */
-	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
-		update_min_vruntime(cfs_rq);
-
 	if (cfs_rq->nr_running == 0)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 }
-- 
2.34.1

