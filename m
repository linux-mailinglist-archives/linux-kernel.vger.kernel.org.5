Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF67980C9A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjLKMXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343591AbjLKMXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:23:13 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D14F101
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:22:49 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2cb20c82a79so39679841fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702297366; x=1702902166; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CqXikia8W4wKYCOhwuwI43am3TB+djJHD+2XeEa4m1U=;
        b=F18EuBi0LIBX2oLDrtfOuAnx7zsdmY0bIoSV8NwfJPNQWvA6MqEgJY8NYLjvTPX2Va
         tPBaiUtiJHXU4tNijiEzIYu3KKk2qoBzlvo0H10wogProdabToY0GUnPF6rKXevT4L80
         7jQ3+vhV+8ovQWzSODlRDgy3AJOt5RZ+6GrM0YfSuesWWR3opW0HWs1o+OSyvi+UXVdj
         t7QeT+c7Q7vvJhw0CSoHQTMA8EruBytZGXoqVmM1xKYEOaQrii/MNi2va2ZoB7XX6MQR
         U8hpHDPbAduhHttG/0900IcU5jSyGOpndEJe4iHgc5hGBPJn6kzpgQ/nd6Kj3IpvyueI
         Oj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297366; x=1702902166;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqXikia8W4wKYCOhwuwI43am3TB+djJHD+2XeEa4m1U=;
        b=Lfy1aBJ4Y+CCu7M9jJN7SOVEQ1pgM8Oianijeyu0wZf1eY7emNsKDCTOQGzRZpVwQo
         IfiODo0htzA81AvH2wq0uWNtrjIwzWKJynhyFPAoBHfi6TPVHyoWWLLP0X48OP0wOPbq
         h06m5q9fByOjWZMtskbwNK/Il6ml9Zg8SUYCGGT9CqmQFLQwjzTLSQev8VZR6lOyJLmE
         2RvV+Z8Lz/jWKhNqhX/cvKJNswTrzIC0As8AXLQxXbWHZWIjGooZFe6eu8EkQaN9TK0R
         s239Kf2CeLdyo6W5lmQeZn172cxbEym/osrcKmV5T64e09F+IffbucU92ApPXah92V0X
         CXPA==
X-Gm-Message-State: AOJu0YwSWT27xc0quIP9OfUKqlOXtbH2FXeyACAuW5qtzCgJZCp/PWgk
        ErHJhMDApdNEO5fnr/5XRHnl2QvvuBOs/OWI0SaG96xD3NQbpQ==
X-Google-Smtp-Source: AGHT+IEJeqd1en40x7iZZ1OU6nooqDmMe2n9YboQZYSYbxbg5CakBS5JIlL7rksm5y1m+OKi/tk5OSO/1mqW840Rqcs=
X-Received: by 2002:a2e:954b:0:b0:2ca:2801:5c41 with SMTP id
 t11-20020a2e954b000000b002ca28015c41mr1749380ljh.21.1702297366298; Mon, 11
 Dec 2023 04:22:46 -0800 (PST)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 11 Dec 2023 17:52:33 +0530
Message-ID: <CAHP4M8WXa-xby4gzUT7ngkuDYhKNReRJ46xHmxzQWzaKvFxFpg@mail.gmail.com>
Subject: Queries on sleeping and scheduling in interrupt-context
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

I am not 100% sure about some of the best practices while writing code
in interrupt-context.
Will be grateful to have confirmation of my thoughts from the experts :)

For all the queries, we assume that there are no thread-affinities to
any processor.
Also, we assume there are no locking/synchronisation worries as of now.


1.
A thread in interrupt-context is not schedulable.
Is this a mandate that is true under all conditions?

2.
Assuming the answer to 1. is yes :

On uniprocessor systems, code in interrupt-context *must never*
sleep/spin to wait (since the current thread cannot be scheduled,
which means that no other thread can get scheduled on the singular
processor, which means that the condition will never become true).

Is my understanding correct?

3.
Assuming the answer to 1. is yes :

On multiprocessor systems, code in interrupt-context *can* sleep/spin
to wait (since another thread can get scheduled on a different
processor, and the condition can then become true, and the current
thread can then come out of sleeping/spinning/waiting).

Is my understanding correct?


Once again, many thanks in advance for all the help.


Thanks and Regards,
Ajay
