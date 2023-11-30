Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316E07FFC70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376721AbjK3U2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjK3U2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:28:31 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3195106;
        Thu, 30 Nov 2023 12:28:37 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1449445276.2;
        Thu, 30 Nov 2023 12:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701376117; x=1701980917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYgokxpdXnom83isGSeLIiEWyDvQWuc8uahFIcEFCiU=;
        b=lT+0NxUgwEKXHXQwHxoAPu8UiUMQRKxIr/R2Wo/G87IfsGfZLZqqMfT/MAgw1agiY5
         NbYzaAuSQXMqkwA/ZGRj9AAHLyI9HhXDxpk56CUrSFUurGa3Mm5YqPsJhZLW+rKGSEag
         8d9ooJHB83tjWRd4eV85vB1r1g7G/K8N1aBTbz/TxYAu0aWmcoqUgdK4jN1gsrxcND79
         CD1x9LP7qJYwP/5VAZMK6zqSClv7W/L78hfQe2yrEXO9XnR2qvL2pUz44VFG5Spb9gmj
         leELW/F/dPzivqrVV+8ptS2aqMX4G1ccDrVXkzfB/7ixMa2dii/gsUzy237VCuZktGrN
         o7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376117; x=1701980917;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YYgokxpdXnom83isGSeLIiEWyDvQWuc8uahFIcEFCiU=;
        b=jAriABDXGTvtxfziSgX8WzTBROg+F99vUmLUVwpjs9FDFIVRtlI70okz3Nd6HygIRG
         gKQa2z0lmNGDaiZhhHum8Os8sln/kXSq8Yxwer5AsNcksrUgEaZ3v8SEpsyOF+jyrYfy
         xcTFv73bCZQYf7c1wiursiLS0pYgzAC556iRfbdBXft2c0xAqnpmdmZH0Ps8WBhe8AxX
         2b2h/V+Eyfz1wnXkUfumLaQYVet2lNSC5p4zBLFi5pxfYG6l9Eb5D1VoFj2SRGI23KwA
         XCl9DjxgjIoocyT90eUvkjewsYA+RvIhg6WVbGSBTfemJje+Rk1P4ZlEXIAn4rwADHXu
         ZMQw==
X-Gm-Message-State: AOJu0YzG/k8xhQpOWbgfLgU3ni+kYhrO4IWcrfBER35PPr0b/jgP5bn2
        RJaNN5C8ZMm3Zy0adOsw9mk=
X-Google-Smtp-Source: AGHT+IHYZiQbkBLJ008rJXlLXZbrmVVGfJZyhDvQvrE7IAhJuIYy3iC3ruuDLfNDxv8+R4e1qKgz3Q==
X-Received: by 2002:a25:268f:0:b0:db5:4938:483 with SMTP id m137-20020a25268f000000b00db549380483mr975627ybm.32.1701376116773;
        Thu, 30 Nov 2023 12:28:36 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id q2-20020a0c9a42000000b00679d7e76b64sm800622qvd.126.2023.11.30.12.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:28:36 -0800 (PST)
Date:   Thu, 30 Nov 2023 15:28:36 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Song Yoong Siang <yoong.siang.song@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        xdp-hints@xdp-project.net,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Song Yoong Siang <yoong.siang.song@intel.com>
Message-ID: <6568f07418508_fbb8229478@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231130162028.852006-2-yoong.siang.song@intel.com>
References: <20231130162028.852006-1-yoong.siang.song@intel.com>
 <20231130162028.852006-2-yoong.siang.song@intel.com>
Subject: Re: [PATCH bpf-next 1/3] xsk: add launch time support to XDP Tx
 metadata
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Yoong Siang wrote:
> This patch extends the XDP Tx metadata framework to include Time-Based
> Scheduling (TBS) support where the NIC will schedule a packet for
> transmission at a pre-determined time called launch time. The value of
> launch time is communicated from user space to Ethernet driver via
> launch_time field of struct xsk_tx_metadata.
> 
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>  Documentation/netlink/specs/netdev.yaml      |  4 ++++
>  Documentation/networking/xsk-tx-metadata.rst |  5 +++++
>  include/net/xdp_sock.h                       | 10 ++++++++++
>  include/net/xdp_sock_drv.h                   |  1 +
>  include/uapi/linux/if_xdp.h                  |  9 +++++++++
>  include/uapi/linux/netdev.h                  |  3 +++
>  net/core/netdev-genl.c                       |  2 ++
>  net/xdp/xsk.c                                |  3 +++
>  tools/include/uapi/linux/if_xdp.h            |  9 +++++++++
>  tools/include/uapi/linux/netdev.h            |  3 +++
>  tools/net/ynl/generated/netdev-user.c        |  1 +
>  11 files changed, 50 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 00439bcbd2e3..a602776bbfb4 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -66,6 +66,10 @@ definitions:
>          name: tx-checksum
>          doc:
>            L3 checksum HW offload is supported by the driver.
> +      -
> +        name: launch-time
> +        doc:
> +          HW Time-Based Scheduling (TBS) is supported by the driver.

Can we avoid introducing another term? We already have too many:
launchtime, earliest delivery time (EDT), SO_TXTIME,
pacing offload, earliest txtime first (ETF).  


