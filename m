Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80237EE742
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345497AbjKPTPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjKPTPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:15:16 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0815CD57
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:15:13 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so1123216b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700162112; x=1700766912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itQbu3UftA7q2hw/NFSZTVr92javRTdC5UMmRHbj2Bw=;
        b=BCjOs9c6naNNxZanB9m+Z9Jyj8rWbEqdvk17Bt1XcfLKuEFp8bhCNpvLrltkKVX+5B
         Tffllcez6iqqM7u9PcaxmnNIgEwtozY5ADPhV1MQNPEqbAU+BVzcWYdOHhh9QrIyZR4E
         JYFX1VrB8QD5l8Et/yBKhLU4+h806cTYOBdZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162112; x=1700766912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itQbu3UftA7q2hw/NFSZTVr92javRTdC5UMmRHbj2Bw=;
        b=tAk2pk7vFm44d7iblVpUsWAnIQKhPlwhIs2gpt2ySWYgpU9wSvCbEzUKiIyeHohoOc
         bUnlLD+u6yAkU1cP1iXnGr3Pu3eogoU5V5AAGHn+DSaI6hojm0BXPf4cvXV4ZN0o+TBl
         rWMgii/OoQRktyvsfqq/dtWHkNRT+CH6IyjVz5WRjbO7UBcA2IH6dVvQo87Gf2Lbzh2Q
         6QHue3JAdJCJrwDrKg7aaO4s1dsxoS+m5/FQNCpuz4WDj9v2HXJ0ZWzXWuvhhWiwAGlx
         q51xffr6GB/yx3S58UkZ5KghYMmib5a2zfH2eYsG3lxZxOr2RBDFU5rwzHQfd3USh9eT
         D9ng==
X-Gm-Message-State: AOJu0YyrP8Gms8jA4SZKQ1840Zvkx42Br3YHU0+bAt6M92IluPnFm4t5
        Kr5z5KWqCcZUUfgBatIDNu+gaw==
X-Google-Smtp-Source: AGHT+IEM6j6q2J53dhIxEHjwnlzX0+Y1Bt56wxP95opav+UU+3PZtdnLeNzVZHJV+dtvRYhv3MmgTw==
X-Received: by 2002:a05:6a20:3d8f:b0:187:1c5c:49e4 with SMTP id s15-20020a056a203d8f00b001871c5c49e4mr9407286pzi.46.1700162112330;
        Thu, 16 Nov 2023 11:15:12 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u7-20020a056a00124700b006b8bb35e313sm78111pfi.103.2023.11.16.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:15:12 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] samples: Replace strlcpy() with strscpy()
Date:   Thu, 16 Nov 2023 11:15:10 -0800
Message-Id: <20231116191510.work.550-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3297; i=keescook@chromium.org;
 h=from:subject:message-id; bh=8RWyq4KVPGbZtO3osk9HAjbi6tNH2MBW0RVY7xAVSV4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVmo+7LLVFxN0AZHfhyD824mNHu4H1YNT5WEHd
 jCOwpvPjWiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZqPgAKCRCJcvTf3G3A
 JsMwD/9v8oRd7dP1JrSwAPMk6+Wswvsl7EXZsrd0/8AuGTD61idVFJ5KK8HyRX5hYiHBZnxo7As
 r6s7O1gn9jeyLRGyTfAsJgYpu1E/XxQobeTONUepIrI4s1dywUx2hoUUyP9Ml8Op5KxUTi0RPS9
 MGNT1NdfG4ALEnF9PRQar9EJ1oIE0MAvhkYb9VF536or88XpQWrDqnCDrdcZjVy3/wk1njAhYwg
 COO3z6PA0qnajm9+JBuCETaFmkQ/Zoi/0ixw21J8gh6u7sjr39cO5x0YNpKFpQebfzw33VQi6qw
 KVxqTC/xrJF/ZjVXTBu5xSpsQaxj7bv8GtKf9mzOU0K8fTURElEVbYxuvSjdwcasE2k8zSAg1Us
 6/X7QiYpsA2c3tR0eKs89X8PabH2lQjB13ieFi89p33YReO3PyohOGakL7CsJy/4xxbC/dchZV0
 7GjybpjDuzWkHP/0nNTH45WdYYsJ3YUUb8WWbMq/2TCr89yoExGFlMbPCCiPwbpe+uYFOhV524o
 AvUPhxWBVNK7Y6D2HUDICv7tyAwM4mceRYIJq/L0COQDTqNmGzq8IEOGcJHMfLT/smzsoCwg0Ug
 ux9FgCI7HS7BknE40dkd2DCfTEqKQmJ439MQnoGoa35x2F+OlFIr8e+cec/DI95Ep2gAUrRl+Kg
 DtD781K vmCi5Jzg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Geliang Tang <geliang.tang@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 samples/trace_events/trace-events-sample.h |  2 +-
 samples/v4l/v4l2-pci-skeleton.c            | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 1c6b843b8c4e..23f923ccd529 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -305,7 +305,7 @@ TRACE_EVENT(foo_bar,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->foo, foo, 10);
+		strscpy(__entry->foo, foo, 10);
 		__entry->bar	= bar;
 		memcpy(__get_dynamic_array(list), lst,
 		       __length_of(lst) * sizeof(int));
diff --git a/samples/v4l/v4l2-pci-skeleton.c b/samples/v4l/v4l2-pci-skeleton.c
index a61f94db18d9..69ef788d9e3b 100644
--- a/samples/v4l/v4l2-pci-skeleton.c
+++ b/samples/v4l/v4l2-pci-skeleton.c
@@ -291,8 +291,8 @@ static int skeleton_querycap(struct file *file, void *priv,
 {
 	struct skeleton *skel = video_drvdata(file);
 
-	strlcpy(cap->driver, KBUILD_MODNAME, sizeof(cap->driver));
-	strlcpy(cap->card, "V4L2 PCI Skeleton", sizeof(cap->card));
+	strscpy(cap->driver, KBUILD_MODNAME, sizeof(cap->driver));
+	strscpy(cap->card, "V4L2 PCI Skeleton", sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info), "PCI:%s",
 		 pci_name(skel->pdev));
 	return 0;
@@ -597,11 +597,11 @@ static int skeleton_enum_input(struct file *file, void *priv,
 	i->type = V4L2_INPUT_TYPE_CAMERA;
 	if (i->index == 0) {
 		i->std = SKEL_TVNORMS;
-		strlcpy(i->name, "S-Video", sizeof(i->name));
+		strscpy(i->name, "S-Video", sizeof(i->name));
 		i->capabilities = V4L2_IN_CAP_STD;
 	} else {
 		i->std = 0;
-		strlcpy(i->name, "HDMI", sizeof(i->name));
+		strscpy(i->name, "HDMI", sizeof(i->name));
 		i->capabilities = V4L2_IN_CAP_DV_TIMINGS;
 	}
 	return 0;
@@ -845,7 +845,7 @@ static int skeleton_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Initialize the video_device structure */
 	vdev = &skel->vdev;
-	strlcpy(vdev->name, KBUILD_MODNAME, sizeof(vdev->name));
+	strscpy(vdev->name, KBUILD_MODNAME, sizeof(vdev->name));
 	/*
 	 * There is nothing to clean up, so release is set to an empty release
 	 * function. The release callback must be non-NULL.
-- 
2.34.1

