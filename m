Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7C7F469A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343850AbjKVMtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343669AbjKVMtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:49:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D857812C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:49:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B8AC433C7;
        Wed, 22 Nov 2023 12:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700657341;
        bh=6OXBSUL+nsBWDSWY/Q2r+0obUk1WW2944LvuwrKFOOg=;
        h=From:Subject:Date:To:Cc:From;
        b=Tc/2BAOyq/CL424TPKJ+8ok4iD2CSlMj4gj7I88R2wR3SRpoXrwpPP4CcDv0rCy4Q
         imtDsj4NMmiBNZozdVII4r1Tu0lKWkktCHU3pI4LzAIFYMYIaMFpbulm6tUMVwguK4
         qTlrJ2u4/DeMIiXbQyzfXkH/WxJG3G65JVkRZ5lf6r4VzUJTQXH/UjyJJ0V5cZAl2s
         w/spDO6VPLhtfPliBsbbdWVAXUjht3ojtCQDl0LfCWNNwph8Zdy7ZX7mLHL0no3jWG
         z8IdhyFNF5VEPzmpKIFkxea1CvPQqUVZAxIi/ByG3Lv1c90SwdjDEIcrL99R5YQgIg
         fP3gmG5BvwYWQ==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/4] eventfd: simplify signal helpers
Date:   Wed, 22 Nov 2023 13:48:21 +0100
Message-Id: <20231122-vfs-eventfd-signal-v2-0-bd549b14ce0c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJX4XWUC/32OTQ6CMBBGr0K6dkhbYpu48h6GRX8GaMRiZkijI
 dzdwgFcvsV737cJRkrI4tZsgrAkTkuuoC+NCJPLI0KKlYWWupNWdVAGBiyY1yECpzG7GaSXURn
 rosEgqvgmHNLnjD76yt4xgieXw3SkXo5XpLaY1gIFdRhT4nWh7/miqMP7O1gUSLBDdCZco1ba3
 59IGed2oVH0+77/ALQAWw7XAAAA
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>, Oded Gabbay <ogabbay@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>, Fei Li <fei1.li@intel.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fpga@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-aio@kvack.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=564; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6OXBSUL+nsBWDSWY/Q2r+0obUk1WW2944LvuwrKFOOg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTG/lhzPFmKbc7Vgs4lut/eP1hw9bOuxtyeI9s4tYwWe
 yZZxby53lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRf4IM/8NUuv3TH0hJOWz8
 c65PTujVFLaLGrq6vFP/9yxi7X77UInhf0113erTobU10gp/tt37unHeHp8P0ZHTLq5c7sWdN//
 2D04A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

This simplifies the eventfd_signal() and eventfd_signal_mask() helpers
significantly. They can be made void and not take any unnecessary
arguments.

I've added a few more simplifications based on Sean's suggestion.

Signed-off-by: Christian Brauner <brauner@kernel.org>

Changes in v2:
- further simplify helpers
- Link to v1: https://lore.kernel.org/r/20230713-vfs-eventfd-signal-v1-0-7fda6c5d212b@kernel.org

---



---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20230713-vfs-eventfd-signal-0b0d167ad6ec

