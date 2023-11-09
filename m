Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEDB7E61CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 02:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjKIB2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 20:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKIB2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 20:28:22 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA7E258C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 17:27:55 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so256085a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 17:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699493274; x=1700098074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=baE0QkFBkm69A7/KmX1olgrrF0ZpXIH/VwZM7lqHCgE=;
        b=ZCrQUONZsHpgXvLGz/mqgU7RcGxD62OqPfkTNYc0SgirTf8jFhLFNNGPQnGqbdlkLa
         p5Vhsvo6Rs/n2TQl3LDLyOES7IRJKvWmnQM00MVIFvIcVNjbiW9rIxWZLc/LqJynCaVS
         //JFNOeOUh8fJ5Pja+mA+NZUZSd2NJhi8I46HMzjrewGnuktkoplO3/zZvotF67OxMcS
         HpPjQmluKQ0qkp7UdlhX36B+FaV3vVwN4YFVJbHn9oGcnITFD/2yLHyoy6Hp0q4PfCyg
         JKamdfjvgDSShhhKJ+TH/Gbbglyuj7xbFmWqdBY0f/PsOmAO7EMaAARaCsTUEb/O3oXU
         uXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699493274; x=1700098074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baE0QkFBkm69A7/KmX1olgrrF0ZpXIH/VwZM7lqHCgE=;
        b=TNY7vlt1Z2EgQu0jsh7lta+tvTuBveV8zvvYsqYVGFjX+mwmYlbi94RRpNkjkNDv8+
         mhsUVbcu7+a+UosMQbXdYHLAvTi+IqvdI6ZWuywSwbvJy+pJ8m1Z06wKNEpiVbwenuW+
         wyUSjY/6CjlAhJFwViPoKU2jXPh06fdpFbxfok9ryNkpqNNwYtpxilcp2vNjU5ASqJzU
         33dw/44gjI9cz7IqeLQFkH9XQartX+UTYrEdp67cXPeEhyPfAzsmnsIMul1OuWNejscO
         q9yCow8gxWJTbooYQ8PYv0KTt9No26ww7Qx6zsh2hRfPUWdjLT7DQliIeQ1AOrmAIgRU
         Z+HQ==
X-Gm-Message-State: AOJu0YxjFweY5N0v4YzzdUVQ/Pl1kQO9cDjUoyxTyCjFjCG0WTMu6xUz
        suiHtxRvFbRkVq7D6uSW8+Stnw==
X-Google-Smtp-Source: AGHT+IEhHoFq6CLb7HH93zopsT2C4lI5MytKERcJeOPmAxoF8kXhwdjHE1xz8CmSnC38AVszTgVYjg==
X-Received: by 2002:a05:6a20:728a:b0:14c:a53c:498c with SMTP id o10-20020a056a20728a00b0014ca53c498cmr3942526pzk.10.1699493274506;
        Wed, 08 Nov 2023 17:27:54 -0800 (PST)
Received: from ?IPV6:2409:8a28:e60:6e40:6:afb5:b160:8513? ([2409:8a28:e60:6e40:6:afb5:b160:8513])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902e54b00b001cc3f9b70e9sm2288783plf.220.2023.11.08.17.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 17:27:53 -0800 (PST)
Message-ID: <7ed9f6f9-d309-4d30-9b3b-c465cfa48a52@bytedance.com>
Date:   Thu, 9 Nov 2023 09:27:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] WARNING in blk_mq_start_request
To:     syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>,
        axboe@kernel.dk, bvanassche@acm.org, chaitanyak@nvidia.com,
        eadavis@qq.com, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <00000000000077ca930609aa9f86@google.com>
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <00000000000077ca930609aa9f86@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/9 05:18, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit d78bfa1346ab1fe04d20aa45a0678d1fc866f37c
> Author: Chengming Zhou <zhouchengming@bytedance.com>
> Date:   Wed Sep 13 15:16:16 2023 +0000
> 
>     block/null_blk: add queue_rqs() support
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106414a8e80000
> start commit:   13d88ac54ddd Merge tag 'vfs-6.7.fsid' of git://git.kernel...
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=126414a8e80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=146414a8e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
> dashboard link: https://syzkaller.appspot.com/bug?extid=fcc47ba2476570cbbeb0
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1465bb08e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e7881f680000
> 
> Reported-by: syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com
> Fixes: d78bfa1346ab ("block/null_blk: add queue_rqs() support")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled in the kernel config,
so null_queue_rq() will return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE
for some requests, which have been marked as IN_FLIGHT status.

Then null_queue_rqs() put these requests in the rqlist and return back,
blk-mq will try to queue them individually once again, caused the warning
"WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE)" in blk_mq_start_request().

So handling of return value of null_queue_rq() in null_queue_rqs() is wrong,
maybe we should __blk_mq_requeue_request() for these requests, before
adding them in the rqlist?

Thanks!
