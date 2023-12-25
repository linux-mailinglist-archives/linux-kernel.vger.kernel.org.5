Return-Path: <linux-kernel+bounces-10967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6654381DF64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20890281CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986B3D9C;
	Mon, 25 Dec 2023 09:09:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DC1C32
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3367f8757d0so650288f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 01:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703495372; x=1704100172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcqUZ4I1aXMWGhgVAAt6UYjQ5+a0myvwxtYCWAHuYPU=;
        b=UPmzJAqoijEDxyHE6H/qFxPhT2egreIJa91vZXX6y2RQPS3KWCwYKE0x3wPvIpLnan
         zPiO6Ot0u98lb5jqFwsvWuMWEu+kgS2swnpoUSVQkW2gJl447b2yQayDqPK4oa0/WqD9
         fJbsbls2lIkTtgcKz2/TMEgbcir9dMAfLMBQfQjPt2ssvvhrazAnJZZNG+W3C3WkHmvm
         OWP67d3ZULRg5RyyMW5ik+HlwtWZWusHJW/pzvVA6uS9DoV57nQYcXsRj3MCWxLhTjad
         x5yx5n2MF+ZdDvYKDcjLwc+B/gLL3I8yZVRevUtZHVfFVj0XZ4QG8XQbp0vplDOQMGzF
         /SBA==
X-Gm-Message-State: AOJu0Ywf1aGtVB0EoNfF+N3sK/OuzkPzq8sxAiTS8RT0Vf1k9F0CXuUD
	oWWS0ZyXdnaCosBksH3Z9eytBxAhQPw=
X-Google-Smtp-Source: AGHT+IHf8ba6RyAQazIKGAMqpV46oxWzPnAE1NrIfBiVJB8heqammukE1L2fv01HnN9xn/CKqpKI4g==
X-Received: by 2002:a05:600c:1d02:b0:40d:5547:11dd with SMTP id l2-20020a05600c1d0200b0040d554711ddmr2499665wms.1.1703495372205;
        Mon, 25 Dec 2023 01:09:32 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b0040d3b0780d5sm16875603wms.30.2023.12.25.01.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 01:09:31 -0800 (PST)
Message-ID: <d84dfede-8efd-4446-b273-03dbf6fcbc10@grimberg.me>
Date: Mon, 25 Dec 2023 11:09:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] nvme-tcp: fix a possible double-free after failed to send
 request
Content-Language: en-US
To: zhangyanjun@cestc.cn, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231222111225.72015-1-zhangyanjun@cestc.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231222111225.72015-1-zhangyanjun@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/22/23 13:12, zhangyanjun@cestc.cn wrote:
> From: Yanjun Zhang <zhangyanjun@cestc.cn>
> 
> In storage clusters constructed by nvme-tcp driver, we have encountered
> the following crash on the host kernel severval times.
> 
> [248514.030873] nvme nvme1: failed to send request -13
> [248514.035916] ------------[ cut here ]------------
> [248514.035918] kernel BUG at mm/slub.c:379!
> [248514.037647] invalid opcode: 0000 [#1] SMP NOPTI
> [248514.039416] CPU: 0 PID: 9 Comm: kworker/0:1H Kdump: loaded Tainted: G S                5.15.67-6.cl9.x86_64 #1
> [248514.041376] Hardware name: CECLOUD CeaStor 16114/BC13MBSBC, BIOS 1.37 02/24/2023
> [248514.043433] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
> [248514.045576] RIP: 0010:__slab_free+0x16a/0x320
> [248514.047751] Code: 24 20 e8 69 28 78 00 44 8b 44 24 0c 4c 8b 54 24 10 44 0f b6 5c 24 1b 0f b6 74 24 1c 48 89 04 24 4c 8b 4c 24 20 e9 28 ff ff ff <0f> 0b 41 f7 46 08 00 0d 21 00 75 a0 4d 85 ed 75 9b 80 4c 24 5b 80
> [248514.052500] RSP: 0018:ff51b1a6c0273bf0 EFLAGS: 00010246
> [248514.054798] RAX: ff2378e68268b800 RBX: 0000000080080004 RCX: ff2378e68268b000
> [248514.057038] RDX: ff2378e68268b000 RSI: ffca59110c09a200 RDI: ff2378a480034d00
> [248514.059245] RBP: ff51b1a6c0273c90 R08: 0000000000000001 R09: ffffffffc0901a0a
> [248514.061386] R10: ff2378e68268b000 R11: ffffffff86e06000 R12: ffca59110c09a200
> [248514.063423] R13: ff2378e68268b000 R14: ff2378a480034d00 R15: 0000000000000078
> [248514.065428] FS:  0000000000000000(0000) GS:ff2378d32fe00000(0000) knlGS:0000000000000000
> [248514.067456] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [248514.069531] CR2: 00007f4759e1c800 CR3: 0000001b5e5a6005 CR4: 0000000000771ef0
> [248514.071706] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [248514.073916] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [248514.076130] PKRU: 55555554
> [248514.078392] Call Trace:
> [248514.080640]  <TASK>
> [248514.082898]  ? sk_stream_alloc_skb+0x66/0x2e0
> [248514.085231]  ? tcp_skb_entail+0x11d/0x130
> [248514.087595]  ? tcp_build_frag+0xf0/0x390
> [248514.089980]  ? nvme_complete_rq+0x1a/0x1f0 [nvme_core]
> [248514.092433]  kfree+0x215/0x240
> [248514.094918]  nvme_complete_rq+0x1a/0x1f0 [nvme_core]
> [248514.097469]  nvme_tcp_recv_pdu+0x534/0x570 [nvme_tcp]
> [248514.100070]  nvme_tcp_recv_skb+0x4f/0x23e [nvme_tcp]
> [248514.102699]  ? nvme_tcp_recv_pdu+0x570/0x570 [nvme_tcp]
> [248514.105317]  tcp_read_sock+0xa0/0x270
> [248514.107958]  nvme_tcp_try_recv+0x65/0xa0 [nvme_tcp]
> [248514.110666]  ? nvme_tcp_try_send+0x16b/0x200 [nvme_tcp]
> [248514.113431]  nvme_tcp_io_work+0x4d/0xa0 [nvme_tcp]
> [248514.116247]  process_one_work+0x1e8/0x390
> [248514.119085]  worker_thread+0x53/0x3d0
> [248514.121980]  ? process_one_work+0x390/0x390
> [248514.124887]  kthread+0x124/0x150
> [248514.127835]  ? set_kthread_struct+0x50/0x50
> [248514.130836]  ret_from_fork+0x1f/0x30
> [248514.133841]  </TASK>
> 
> By analyzing the vmcore, we know the direct cause is that the slab object
> request->special_vec was freed twicely. According to the error message
> "nvme nvme1: failed to send request -13" and nvme_tcp_request->state =
> NVME_TCP_SEND_DATA, the pdu has been send by nvme_tcp_try_send_cmd_pdu.

So what exactly failed to send? incapsule date? Or h2cdata?

> And the nvme_tcp_fail_request would execute nvme_complete_rq after failed
> to send data.

That is correct.

> Then the nvme_tcp_recv_pdu may receive the responding pdu

Which PDU was that? Isn't the controller expecting request data?

> and the nvme_tcp_process_nvme_cqe would complete the request again. To
> avoid this slab object double-free issuse, we try to make the following
> code modifications, can you give some suggestions, thanks!
> 
> Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
> ---
>   drivers/nvme/host/tcp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 08805f027..84f724558 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -581,6 +581,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		return -EINVAL;
>   	}
>   
> +	if (!blk_mq_request_started(rq))
> +		return 0;

First, I want to understand if this is a spurious completion, meaning is
this suggesting a protection against a misbehaving controller? Or there
was actually something that the host got wrong?

Because this sort of check does not belong in the tcp driver.

