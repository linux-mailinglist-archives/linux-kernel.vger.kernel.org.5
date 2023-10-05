Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B257BA6C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjJEQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjJEQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:39:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDBE9EC3;
        Thu,  5 Oct 2023 02:01:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-325e9cd483eso731265f8f.2;
        Thu, 05 Oct 2023 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696496480; x=1697101280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nyCjyMRZJPpmlXHrivKxtsx8HD0NSj+fcEZELdzdDEQ=;
        b=Rl9qiaC6E4CPjVzA2ffAgqUOlM7epwfWWskPrOAtio1Bgz9Ivh+hpIMkTOaqW6MG6g
         tC5BvfdSlJq8My5xgrklxIGUASaG2C4EkkuggdwPPQhDl9jz8VGKJcljBEQQRaBBHcXs
         HKkXgphDYCLa02Z+WBGEL2hYgO/Un1JLQYPc3/xsdscqmnUVkzM2N9e/4k7jpbZOr1+9
         h7tDTg+kiuJDlxWFzWWzEYhJIP4ZLA8X9A77RmuJGfkK+yMp19dy2v24ouIOdklavYvS
         AAp3SIlX3UaPILsFzXd5PBZghRktUSpeHUNDuNbHIDB5rYSbrjqVycQ8ASPRQbSIHNac
         AGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696496480; x=1697101280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyCjyMRZJPpmlXHrivKxtsx8HD0NSj+fcEZELdzdDEQ=;
        b=r0aHURFeQ4YALc5AJ1LKezB3Nlhoc3oW6Sq2PUVm87wDfKB9kE8dnGwbf8Y4ADO19X
         Gkv3vxgpSMk8S4PnFurBgesMDKVEPYQ4YU2rL0EEyQd/iK3voJXnbOOeaR8WKvFo4fkV
         Ca2+mXeRK48pavz5tCLh7gCWqUCY6SbRjQsrW/r9zSZ/BYjcgBTZ2jbLIEyGn0ExjMR4
         pXf/nbsLVGaadhktaRBr82r6YlPRi84G/2tGekyJ8XkA0cWjfbrMLObG11q0ze8O1RAr
         YyCj6burZHlHstjNS4szvJmWXVtvfJhppdYz+an+JPh0IBSuOjAP5j2jj9CFjJX7Y2fb
         v+EQ==
X-Gm-Message-State: AOJu0YyU4BsKhS30/ewHEfAxeAILYS/1ugDyTSLKUhzP5mTSkQU7ngL1
        ZraEM+10f7+XRNb7Y4C++S2yNkUhlhBIWjzs4Jw=
X-Google-Smtp-Source: AGHT+IFIPFt0C+RQD6SfEGDNp/O1EcsXM3cXS55wuqm/OjC897gfV9/lodgbKZQ3zWKSi7n3ZjBLYo9o40siMK6OUUQ=
X-Received: by 2002:adf:edc3:0:b0:321:56af:5ef9 with SMTP id
 v3-20020adfedc3000000b0032156af5ef9mr3840408wro.70.1696496479494; Thu, 05 Oct
 2023 02:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230926182625.72475-1-dg573847474@gmail.com> <20231004170120.1c80b3b4@kernel.org>
In-Reply-To: <20231004170120.1c80b3b4@kernel.org>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 5 Oct 2023 17:01:07 +0800
Message-ID: <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

Thanks for the reply,

I inspected the code a bit more, it seems that the TC action is called from
tcf_proto_ops.classify() callback, which is called from Qdisc_ops enqueue
callback.

Then Qdisc enqueue callback is from

-> __dev_queue_xmit()
-> __dev_xmit_skb()
-> dev_qdisc_enqueue()

inside the net core. It seems that this __dev_queue_xmit() callback is
typically called from BH context (e.g.,  NET_TX_SOFTIRQ) with BH
already disabled, but sometimes also can from a work queue under
process context, one case is the br_mrp_test_work_expired() inside
net/bridge/br_mrp.c. Does it indicate that this TC action could also be
called with BH enable? I am not a developer so really not sure about it,
as the networking code is a bit long and complicated.

Thanks again,
Chengfeng
