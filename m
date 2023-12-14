Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D1812A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjLNIT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjLNITz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:19:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF90E0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702542000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tRmYmYKdouaq3SuesAh37kIKzoyNX5WPg71KEcwVJ1U=;
        b=DxhLSpC3ykN1G6IKN4EdUGfQUiFv4AJ64WGvR0clcRG13oNgP9Ks2Q5JuOuX0VorDIduCm
        4AQJTFIJjp0nFkrUzKQnjQRgD8HYis+To4qp1UflJmeWrU9Qd7Pntm0C9sfdviI+pEIiMm
        GDhd5IWlgmuI4U7UvLCjguiMnphZLUg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-Jp_CzCEcMYq5UEwmdDro7g-1; Thu, 14 Dec 2023 03:19:58 -0500
X-MC-Unique: Jp_CzCEcMYq5UEwmdDro7g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-333501e22caso6115893f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702541996; x=1703146796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRmYmYKdouaq3SuesAh37kIKzoyNX5WPg71KEcwVJ1U=;
        b=r4l2ehC6ffBeuZS33Fp8Dzudn0kDAmXwCkoyuRmHyiwaGAnmRInHU7ZQV0lh7MZYAn
         PzWariWrL0+LtP0nFc1hTaLEhKY1kae6QwvI2JpUemjkHudC+PGC7AwAgRMl2tG7zw9o
         DWDFlRE40BptXIBFG9j9iRGUO4HwlqNhzE3EYiPW7zwCiWVjCLja6S767XmtpF/UAwJE
         81JLVkeaKrShWQfXGBACtSYgEGpt/l8ucXNmKB9byW6vmRehOd9RGhGFxOE4cx/Q9L+8
         dVd21m/FbMEn4ZH7q6CM9nRJcbcl+Hg7wHVglIpUMSP04MuvDrIb1KRWRVrrbSyfqYt3
         rk3A==
X-Gm-Message-State: AOJu0YyzgNjbTcaeuiQ3Wp/7EpDtUK50uUHPs0/OVhfEv2pWOEDFa2HS
        rYLRKIFS/5yFGej9Ds3X8iKFnmYWhfoikHYzlOITXVNZWuVrWFFNk8dtN+Z6Dhw0/c9TswQoXC9
        gNEETudPbft65VI0qPwJ3kaTV
X-Received: by 2002:a05:6000:1c6:b0:336:4297:b25d with SMTP id t6-20020a05600001c600b003364297b25dmr957838wrx.136.1702541996581;
        Thu, 14 Dec 2023 00:19:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdqvpfAVvf4U6RhyJKj4ac/lPlURzo1wv0qRFNbYaFyfMUYKbpbf2LJr5fGeJFUOmj7q8+yw==
X-Received: by 2002:a05:6000:1c6:b0:336:4297:b25d with SMTP id t6-20020a05600001c600b003364297b25dmr957779wrx.136.1702541996175;
        Thu, 14 Dec 2023 00:19:56 -0800 (PST)
Received: from sgarzare-redhat ([5.11.101.217])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d4ccd000000b003363823d8aesm3920736wrt.59.2023.12.14.00.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 00:19:55 -0800 (PST)
Date:   Thu, 14 Dec 2023 09:19:09 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Jiawen Wu <jiawenwu@trustnetic.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Ronak Doshi <doshir@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH net-next v1 1/4] vsock/virtio: use skb_frag_page()
 helper
Message-ID: <nfhefym2w56uziqgzcloodvtf4wg74skoskhi6dztqqnlabhis@h4rj7p2ivvej>
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-2-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231214020530.2267499-2-almasrymina@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 06:05:24PM -0800, Mina Almasry wrote:
>Minor fix for virtio: code wanting to access the page inside
>the skb should use skb_frag_page() helper, instead of accessing
>bv_page directly. This allows for extensions where the underlying
>memory is not a page.
>
>Signed-off-by: Mina Almasry <almasrymina@google.com>
>
>---
> net/vmw_vsock/virtio_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

LGTM!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index af5bab1acee1..bd0b413dfa3f 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -153,7 +153,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 				 * 'virt_to_phys()' later to fill the buffer descriptor.
> 				 * We don't touch memory at "virtual" address of this page.
> 				 */
>-				va = page_to_virt(skb_frag->bv_page);
>+				va = page_to_virt(skb_frag_page(skb_frag));
> 				sg_init_one(sgs[out_sg],
> 					    va + skb_frag->bv_offset,
> 					    skb_frag->bv_len);
>-- 
>2.43.0.472.g3155946c3a-goog
>

