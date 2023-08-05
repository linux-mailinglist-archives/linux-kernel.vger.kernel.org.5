Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0559F770E15
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 08:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjHEG1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 02:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjHEG1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 02:27:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9CC4ED6;
        Fri,  4 Aug 2023 23:27:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 98e67ed59e1d1-26871992645so1841320a91.0;
        Fri, 04 Aug 2023 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691216825; x=1691821625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=925QF3HnEkWSXdDDliA9Rsgs4P8TSRLdziSE4x6a8Qs=;
        b=YBwgSekYDVhSDkc0X0jh8gOjr+P3cdEi+8YIua5bJoTOTQBay++JIntuUWnoZLjPgV
         NhTSC3FJFP2meyYSCWHy6IVX761SmIhRJ5pQe2tJKRmfMcz7aGxMyxseoPzsdBnSzJ7c
         NdnhEEScgWWQ7IjK8dpVvYtOZZOeRxFrpH/gQK0x0Uqhrb6Z0bkd2uNZf09j2Jfw5bhO
         dnn6DAyuAaR3h/32Ck/eonBQd5dfUj2xqsfqNpISTqduqG7GdAbqCU6i+tDARdV2WRWs
         AiyPboOmz1ktxHzI8EDBMHAGVMWidZ4T+aQX+ny47GXaND/Gzv+OBqnbnTBMu/8U+9Z9
         TgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691216825; x=1691821625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=925QF3HnEkWSXdDDliA9Rsgs4P8TSRLdziSE4x6a8Qs=;
        b=VMPyMa9hL4BzB7F2/0YHB/m/+w7ngtCFJ+sfp+d1FBJ2NEFR8grnP4bOeb2lZTzGKh
         IqcCtW26iYObyI5/rCl7Ij8RfuFsR8S2wwgfraf2F7THiyHshnBY7KAHy3crJGAxpy6f
         KetV0EUaZlbL8v6TAHP2tk74+gNpdWwoVIilmjfkYdcU8mylDzRWF0ug3ZXqmu0Ctcqk
         Agz2gb6yXXf4coX8etSAif0d3t/w5wJSWhzbRRK7fljwNkqvmnLxCS83Jij/YhynIoJN
         e58R3oKbBvf/KuD0TZUjpy+3Wm5E23RwJEqmAM/z8L10EXfoQxKG7eCewaKS9wYX0K0O
         j1YA==
X-Gm-Message-State: AOJu0YxiWG4C9TtgXukEP6hdZlEd7WNlZbsIWukhXorQj84QJFvmRo2Z
        YOu7xN2Zw4NJMeVMBb1RPUs=
X-Google-Smtp-Source: AGHT+IF+0ObRVcsyK7SmE9Yc3Gh4YUUPn96IbcOM5005ryI7mXjhqYYpuJNV5ikejPOpyJu3JAkIRw==
X-Received: by 2002:a17:90a:d242:b0:267:ffcf:e9e3 with SMTP id o2-20020a17090ad24200b00267ffcfe9e3mr3964107pjw.46.1691216824872;
        Fri, 04 Aug 2023 23:27:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id oj3-20020a17090b4d8300b0025bcdada95asm2375362pjb.38.2023.08.04.23.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 23:27:04 -0700 (PDT)
From:   xu <xu.xin.sc@gmail.com>
X-Google-Original-From: xu <xu.xin16@zte.com.cn>
To:     edumazet@google.com
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        yang.yang29@zte.com.cn, xu.xin16@zte.com.cn
Subject: Re: [PATCH] udp_tunnel_nic: add net device refcount tracker
Date:   Sat,  5 Aug 2023 06:27:00 +0000
Message-Id: <20230805062700.235515-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89i+FTKRkgVodoQaCXH632rXx04AEe2_dJkqPiCEdtG0zQA@mail.gmail.com>
References: <CANn89i+FTKRkgVodoQaCXH632rXx04AEe2_dJkqPiCEdtG0zQA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> ---
>>  net/ipv4/udp_tunnel_nic.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
>> index 029219749785..ce8f5c82b0a1 100644
>> --- a/net/ipv4/udp_tunnel_nic.c
>> +++ b/net/ipv4/udp_tunnel_nic.c
>> @@ -55,6 +55,9 @@ struct udp_tunnel_nic {
>>   */
>>  static struct workqueue_struct *udp_tunnel_nic_workqueue;
>>
>> +/* To track netdev_hold and netdev_put */
>> +static netdevice_tracker udp_tunnel_nic_devtracker;
>
>This looks wrong.
>
>> +
>>  static const char *udp_tunnel_nic_tunnel_type_name(unsigned int type)
>>  {
>>         switch (type) {
>> @@ -825,7 +828,7 @@ static int udp_tunnel_nic_register(struct net_device *dev)
>>         }
>>
>>         utn->dev = dev;
>> -       dev_hold(dev);
>> +       netdev_hold(dev, &udp_tunnel_nic_devtracker, GFP_KERNEL);
>
>This is wrong. You need a separate netdevice_tracker per netdev_hold()
>
>For instance, this would need to be in "(struct udp_tunnel_nic)->dev_tracker"

Oh, Sorry, I misunderstand the usage of netdev_hold and its netdevice_tracker.

But cound you please add this this useful information into netdev_hold()' comment,

to prevent others from making the same mistakes with me.

Thanks!

