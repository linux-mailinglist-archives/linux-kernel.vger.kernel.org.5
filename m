Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321A7801EA3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjLBVWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBVWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:22:17 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39CA13A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 13:22:21 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7b06841efdcso123444439f.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 13:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552141; x=1702156941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLvxvckvyomlZOIIg4Wjwswvgj0BL428CVO+nAzlFtE=;
        b=YA5NcrkM5udEWaHHh2G+rmz62ChxvRvmbuIaxK6S0HmU0dsnoYprOaEiaJ+Bbj/pE0
         X8/WCK0HfL43CDLXxWRUeqCFrVa9Xk5RwQEO79zs3ktain0CD+LqjL6cCUM3uEcRVFcX
         ADZbHiYgQnmAcZWmNncFbgqi6QMwCHkKl+XgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552141; x=1702156941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLvxvckvyomlZOIIg4Wjwswvgj0BL428CVO+nAzlFtE=;
        b=nfVGD7+CG1Rfz5C07NCWpYRcZ75FcJ2v7qP90H09+RIh0bHbo5jsgnNzx6eWYTX6AG
         c4UwATf2hsmODbwzm6ks96UufeWx4lwJ3eQIP3vZ1xge1k10lUwXIVUS/9+hxrfvznKs
         9CoHNNXusPcUaq0lRQ2xKOTALh+xsuReTuDJuXvgeouNxhdl+SyXE+K8zTATyyh71xN1
         x3BCgb5kxYfJm2u6i05E5L2ys62TZR9wx84yvd9HTkf5N40aBTeeH3ycOPHjTsMmSMgG
         fyDzV3vlXrCXz8spf6TEWvCPiNK1MYuksoZmFZaRmr4WOWY5815PV2qsZoNSxGy5rIeE
         tRCA==
X-Gm-Message-State: AOJu0YxQwHDCMlhCBbmkxumQzy7f/98shMbd2wQWookyjOEUrEZQal/y
        eLycX8w9nwLx9P3WJmTM4jPe0A==
X-Google-Smtp-Source: AGHT+IGtRLKSAKTdisrEu2j2CjbfWn28z6XUA+T3NZsmq5+CR4/UtQweJAgLKCPRmDEaHRBtmwe+zA==
X-Received: by 2002:a5d:894b:0:b0:7b3:9256:628f with SMTP id b11-20020a5d894b000000b007b39256628fmr2310006iot.15.1701552141318;
        Sat, 02 Dec 2023 13:22:21 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001cfd049528esm348997plj.110.2023.12.02.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:22:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 3/5] fs: Add DEFINE_FREE for struct inode
Date:   Sat,  2 Dec 2023 13:22:13 -0800
Message-Id: <20231202212217.243710-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202211535.work.571-kees@kernel.org>
References: <20231202211535.work.571-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=keescook@chromium.org; h=from:subject; bh=Vr7BZE93w9hrA2pgUGte2wnKY/rdltDnNWxbve4aQVs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla6AGSav5RcGFsYqI8ZI6gPChQFnsbC+3nI/Sq AQMSCvSeJuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWugBgAKCRCJcvTf3G3A Ji1PD/97nsFeEYnRWCY5ijYm3HvFHnw2xsSeLfCgNERlEsvkDTZnVu32g862lrZ6hmNnj1/2WLY q5BTXJyqzwbbUg83+V4Z7IWpauoICvmh5nWCVw+d1swRjKLklznh+kH+lxKH782U5N+1W/bPv70 NdRhJBCPVOIeyBMGaFNtfbgw7Q7/MKTOSU/62VCry3sVE9fgDWP9DnB0W9/AVEf5mttk4aI+XJP Jf0b1606ZtWwo4iih+TPjLRID9WD2cRTVsaeRdH6h2sVpbIWtLfBMYm7MUT4xvIE/X34XC1XbGH /mFyNY6PyZyWNI/tRahhMjKTPtLuV+I51o3tpDU6ScYTIbUYyvn1SktT2ZE2PeBRIK7UUg8Kekf uMNNH7+hll0EcFYUEBOQ4ErCJ6guTCAIxc+68VotsoujHUSgriM/jZWU+UdawDQmyw5w2Zxt2fH io2IkOg0NktS5Lz/oNbESXSgqAIcAsWZYdpz8f5sULzKfDAWY9NZCkKawVLDlwQ3EVVq3ugJ4nO /+MhL408XJIGHI6nAbKY8QyfaPWyUeqbflROQiQEI6UVXEYbPuKogAFFyNGXqSlpZfzWjwQM12w tqybXEWAcWdB/zgRVWCl3j9u393bvwCn78YpxLSABa2mDjF9niWPVYIK3247bi3TGEcoqVKm7/q lL7bpxiJe0Uvk7A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow __free(iput) markings for easier cleanup on inode allocations.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..7c3eed3dd1bf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2459,6 +2459,8 @@ extern int current_umask(void);
 
 extern void ihold(struct inode * inode);
 extern void iput(struct inode *);
+DEFINE_FREE(iput, struct inode *, if (_T) iput(_T))
+
 int inode_update_timestamps(struct inode *inode, int flags);
 int generic_update_time(struct inode *, int);
 
-- 
2.34.1

