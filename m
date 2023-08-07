Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6394772365
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjHGMFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjHGMFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:05:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB2AF0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:05:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2680182bc21so2234988a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691409944; x=1692014744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxNPOJp2gtDhfWZRzOWarZZZVlOwdeuN9g0kWHnf9gs=;
        b=WsVfgJHsSXlOYhSa7RnTOFdsaoX0xEoReCh4sis0XDX/ZC4AZZ4i7l+6ft+Dh8q6vB
         ZANsA/Dtc2VdW8u7FnrP6vhl0HCYwl+0lqeYM5BgkcxalSXu0RgUX8YfcOrtCb+IU5qh
         8tfYLBfQRD8KRBSA3FfUsqZ5ZRrfd2q9Ypk+RU6CqBzKSdW79JSEAfOtj3sDInliciF5
         MIBhYmv1/CGoUDgvZSIAlmIyn9r6HsjyaSq7lbNiasxCJUaJDvoHvCPyqcFX66qUV2iP
         je8aXyp/+daaeX0IfqkVrnyT7rGBLtqve+JO7YPpk4qVZ/pOITQZ/mPUFQmjBzWa0+eY
         sz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691409944; x=1692014744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxNPOJp2gtDhfWZRzOWarZZZVlOwdeuN9g0kWHnf9gs=;
        b=OKb2EcbwdkqDS53HwQJMc+Xz9q9WBmH/pT02O73Za+sPlJS+9f7F86QqVHJHgofT3+
         sYAtOl+rVmzgerS9FHMbjy0ntqzWcgHdH7OmlBCQlBeI4hbvTafXfMA+OHvO0V6P0cQr
         wG+0RfP66wTPEz9ohavFiVMji1n0+QTxKp5nz2mAggA6p4VlpbBnmKGBt5gj3n2Txg8B
         VZ0eVrr4XEfOiop4gu7foU8dlym7s0OrTvErJAwrFQOsWlxdi9W6KOt5rwq5j3sZvymA
         lmYteCKV9iHVjLwST/QBL9fEbKPgiijT5I8MEXFMTsz7eKHkfXHCa6WNAWxNRjzfligF
         UBSQ==
X-Gm-Message-State: AOJu0Yxwem+ypmPv3O1pJJ4u87kAf/wpMwMm7rj/j/7CLsheNhk/OOCa
        p6vSd7RI3NDSb7S00PG8ddqdswjTmEcQoK9FnxdR4g==
X-Google-Smtp-Source: AGHT+IGIntJFzxEfnZfu0K5hC4TFi3jmhVJZWB+WVqNK9Sop7DxQpbxBhPnmG4v2fW+FmoyvjvB0Ag==
X-Received: by 2002:a17:90a:a095:b0:263:53be:5120 with SMTP id r21-20020a17090aa09500b0026353be5120mr6488176pjp.36.1691409943733;
        Mon, 07 Aug 2023 05:05:43 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id bx6-20020a17090af48600b00263f8915aa3sm8578098pjb.31.2023.08.07.05.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:05:43 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:XDP SOCKETS (AF_XDP))
Subject: [RFC v2 Optimizing veth xsk performance 0/9]
Date:   Mon,  7 Aug 2023 20:04:20 +0800
Message-Id: <20230807120434.83644-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AF_XDP is a kernel bypass technology that can greatly improve performance.
However, for virtual devices like veth, even with the use of AF_XDP sockets,
there are still many additional software paths that consume CPU resources. 
This patch series focuses on optimizing the performance of AF_XDP sockets 
for veth virtual devices. Patches 1 to 4 mainly involve preparatory work. 
Patch 5 introduces tx queue and tx napi for packet transmission, while 
patch 8 primarily implements batch sending for IPv4 UDP packets, and patch 9
add support for AF_XDP tx need_wakup feature. These optimizations significantly
reduce the software path and support checksum offload.

I tested those feature with
A typical topology is shown below:
client(send):                                        server:(recv)
veth<-->veth-peer                                    veth1-peer<--->veth1
  1       |                                                  |   7
          |2                                                6|
          |                                                  |
        bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
                  3                    4                 5    
             (machine1)                              (machine2)    
AF_XDP socket is attach to veth and veth1. and send packets to physical NIC(eth0)
veth:(172.17.0.2/24)
bridge:(172.17.0.1/24)
eth0:(192.168.156.66/24)

eth1(172.17.0.2/24)
bridge1:(172.17.0.1/24)
eth0:(192.168.156.88/24)

after set default route、snat、dnat. we can have a tests
to get the performance results.

packets send from veth to veth1:
af_xdp test tool:
link:https://github.com/cclinuxer/libxudp
send:(veth)
./objs/xudpperf send --dst 192.168.156.88:6002 -l 1300
recv:(veth1)
./objs/xudpperf recv --src 172.17.0.2:6002

udp test tool:iperf3
send:(veth)
iperf3 -c 192.168.156.88 -p 6002 -l 1300 -b 0 -u
recv:(veth1)
iperf3 -s -p 6002

performance:
performance:(test weth libxudp lib)
UDP                              : 320 Kpps (with 100% cpu)
AF_XDP   no  zerocopy + no batch : 480 Kpps (with ksoftirqd 100% cpu)
AF_XDP  with  batch  +  zerocopy : 1.5 Mpps (with ksoftirqd 15% cpu)

With af_xdp batch, the libxudp user-space program reaches a bottleneck.
Therefore, the softirq did not reach the limit.

This is just an RFC patch series, and some code details still need 
further consideration. Please review this proposal.

thanks!

v1->v2:
- all the patches pass checkpatch.pl test. suggested by Simon Horman.
- iperf3 tested with -b 0, update the test results. suggested by Paolo Abeni.
- refactor code to make code structure clearer.
- delete some useless code logic in the veth_xsk_tx_xmit function.
- add support for AF_XDP tx need_wakup feature.

Albert Huang (9):
  veth: Implement ethtool's get_ringparam() callback
  xsk: add dma_check_skip for skipping dma check
  veth: add support for send queue
  xsk: add xsk_tx_completed_addr function
  veth: use send queue tx napi to xmit xsk tx desc
  veth: add ndo_xsk_wakeup callback for veth
  sk_buff: add destructor_arg_xsk_pool for zero copy
  veth: af_xdp tx batch support for ipv4 udp
  veth: add support for AF_XDP tx need_wakup feature

 drivers/net/veth.c          | 679 +++++++++++++++++++++++++++++++++++-
 include/linux/skbuff.h      |   2 +
 include/net/xdp_sock_drv.h  |   1 +
 include/net/xsk_buff_pool.h |   1 +
 net/xdp/xsk.c               |   6 +
 net/xdp/xsk_buff_pool.c     |   3 +-
 net/xdp/xsk_queue.h         |  10 +
 7 files changed, 700 insertions(+), 2 deletions(-)

-- 
2.20.1

