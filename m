Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C555E7AD604
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjIYKb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjIYKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C353AAB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695637864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0DpECY4xgD810waS/rgF1VksorNZHYkHpCmfPvNqmEU=;
        b=ePyqz1EsLb9CWe/6RWcb3GbCQq9NpcyiGzTGv647lTewWWn39wro/EMhnqbhgF/JSASoqE
        aNWY6oAmy7mmmqkqQnHL2dm06kqM5/XjaXnMtt2/RtRVcFQbNwmyNky3L0ZprY8coQhidS
        z03mhY3QCnI/gFD8OBJ2K4WpkxJ73s4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-ZwymEXolN8aakM0apb4t3g-1; Mon, 25 Sep 2023 06:31:02 -0400
X-MC-Unique: ZwymEXolN8aakM0apb4t3g-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b8405aace3so79638281fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695637861; x=1696242661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DpECY4xgD810waS/rgF1VksorNZHYkHpCmfPvNqmEU=;
        b=QbjRO6IiBLnc15NtuJS2+Z1UdINDE02ickASS8A/ilCpX8/+Q0dUZMf2KvsuOAl/gB
         3Y0WigUUL6VqZtlZRISasvCxMM+RbP4ukeeomQpjiWiHU/XKDoZ2XScOJXnTto7KWUhK
         Sq5TVoScwMZ0YQDG9z1DGbZMZn61DINmajg7tEKKKqEffiMNDMajk/enJZmwrDi8jCZs
         t+GTpZvgRWIXKx1IVjFR6fCtUH17qAwThSEdMuMZpe69jLhKl9qbZjphGvVGt+JKrLCZ
         ojQVRJycTeejB8iI668B+JsqQ16s5n7oYAZRwEN1ZrHoEXmNHDsEL6dQ+RqGJo7ugt0O
         /28Q==
X-Gm-Message-State: AOJu0Yz+qfmSlQqi5PxYof0EveGGGrDoyhExI9F/reSY6mY2WrZeQ/gr
        14jztJHe51Zasq+53XPfCoLSbrkYApexItge4j9rcv/zVJg4j3hghluLCszteohOMXuFlFTG0Yg
        ZuPHx98amZItvk1CYZouL6YVn
X-Received: by 2002:a2e:8084:0:b0:2bc:fa8f:83c4 with SMTP id i4-20020a2e8084000000b002bcfa8f83c4mr5126302ljg.39.1695637861134;
        Mon, 25 Sep 2023 03:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx1EwDlCVz04qbWgbyK5nfpeoyXqfQ6Qq2TBRTZPqNjJwRcJMbIuZi7IseWRVL8VlZINlyCw==
X-Received: by 2002:a2e:8084:0:b0:2bc:fa8f:83c4 with SMTP id i4-20020a2e8084000000b002bcfa8f83c4mr5126286ljg.39.1695637860736;
        Mon, 25 Sep 2023 03:31:00 -0700 (PDT)
Received: from step1.lan ([46.6.235.141])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b0099cc3c7ace2sm6161066ejb.140.2023.09.25.03.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:30:59 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()
Date:   Mon, 25 Sep 2023 12:30:57 +0200
Message-ID: <20230925103057.104541-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the while loop of vringh_iov_xfer(), `partlen` could be 0 if one of
the `iov` has 0 lenght.
In this case, we should skip the iov and go to the next one.
But calling vringh_kiov_advance() with 0 lenght does not cause the
advancement, since it returns immediately if asked to advance by 0 bytes.

Let's restore the code that was there before commit b8c06ad4d67d
("vringh: implement vringh_kiov_advance()"), avoiding using
vringh_kiov_advance().

Fixes: b8c06ad4d67d ("vringh: implement vringh_kiov_advance()")
Cc: stable@vger.kernel.org
Reported-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vringh.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 955d938eb663..7b8fd977f71c 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -123,8 +123,18 @@ static inline ssize_t vringh_iov_xfer(struct vringh *vrh,
 		done += partlen;
 		len -= partlen;
 		ptr += partlen;
+		iov->consumed += partlen;
+		iov->iov[iov->i].iov_len -= partlen;
+		iov->iov[iov->i].iov_base += partlen;
 
-		vringh_kiov_advance(iov, partlen);
+		if (!iov->iov[iov->i].iov_len) {
+			/* Fix up old iov element then increment. */
+			iov->iov[iov->i].iov_len = iov->consumed;
+			iov->iov[iov->i].iov_base -= iov->consumed;
+
+			iov->consumed = 0;
+			iov->i++;
+		}
 	}
 	return done;
 }
-- 
2.41.0

