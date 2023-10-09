Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D12B7BDD2F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376723AbjJINIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376706AbjJINIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:08:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE1194;
        Mon,  9 Oct 2023 06:08:10 -0700 (PDT)
Date:   Mon, 09 Oct 2023 13:08:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696856887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bEr1MM8/2JauJrDARdrIFSYd1FdtFHHP6Pk0B7CMA2I=;
        b=HVmt6K9QB/yYEVM52Y+FaIxtig6OAjuph9R5H/+p7YEn7lK9FynWgoF40YU8TM4nkAEQsB
        0xbsjh+r/Bct2JOWoyGafp44d9+qJVIteDOTfPBY5YRUWuEedXaDUa5Np15LxyzlA0TwIN
        1u2BAEWSpaApHKQPDk4I9WVNSBSp/3ISPCP70OZBmEiNIGHh3cgFVXR2nl6UBdeTljOUKd
        jXyZ0AspFtE4F4YHvlukYXKrH7AfZd360SJEUAfgtxn8B9n8vcvozjVtgAeuVyvbCJ+9/k
        z0EiVis47+0LebOZmYtgHSUemb6hdm7jBGKpS6CoQskxivaD/yK29AHlpTiLBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696856887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bEr1MM8/2JauJrDARdrIFSYd1FdtFHHP6Pk0B7CMA2I=;
        b=WO1Act2IKjSzxOrweWFXbQNaj6TQi1eEVRRwqpOLpeg2gLddHpActWv4dBXPiw4zBIxHuT
        y4TmzpwQusJu3lBA==
From:   "tip-bot2 for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] rtc: Add API function to return alarm time bound
 by hardware limit
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230915152238.1144706-2-linux@roeck-us.net>
References: <20230915152238.1144706-2-linux@roeck-us.net>
MIME-Version: 1.0
Message-ID: <169685688633.3135.80139071644224201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a0fddaa0b5a587cc8d185f8802fe7e48493c43ed
Gitweb:        https://git.kernel.org/tip/a0fddaa0b5a587cc8d185f8802fe7e48493c43ed
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Fri, 15 Sep 2023 08:22:37 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 09 Oct 2023 15:03:28 +02:00

rtc: Add API function to return alarm time bound by hardware limit

Add rtc_bound_alarmtime() to return the requested alarm timeout bound by
the maxmum alarm timeout that is supported by a given RTC.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230915152238.1144706-2-linux@roeck-us.net

---
 include/linux/rtc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 4c0bcbe..5f8e438 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -225,6 +225,23 @@ static inline bool is_leap_year(unsigned int year)
 	return (!(year % 4) && (year % 100)) || !(year % 400);
 }
 
+/**
+ * rtc_bound_alarmtime() - Return alarm time bound by rtc limit
+ * @rtc: Pointer to rtc device structure
+ * @requested: Requested alarm timeout
+ *
+ * Return: Alarm timeout bound by maximum alarm time supported by rtc.
+ */
+static inline ktime_t rtc_bound_alarmtime(struct rtc_device *rtc,
+					  ktime_t requested)
+{
+	if (rtc->alarm_offset_max &&
+	    rtc->alarm_offset_max * MSEC_PER_SEC < ktime_to_ms(requested))
+		return ms_to_ktime(rtc->alarm_offset_max * MSEC_PER_SEC);
+
+	return requested;
+}
+
 #define devm_rtc_register_device(device) \
 	__devm_rtc_register_device(THIS_MODULE, device)
 
