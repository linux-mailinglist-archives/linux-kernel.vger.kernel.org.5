Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE9D7707F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjHDS1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjHDS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB5B5257
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691173510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fdvxi7T0QQZA7DILvp9xTFYkELtQTf+gq8ZCaeS7cjM=;
        b=idzdiqQs2AC8sIFni7tLrjmMcBn6Le2G7J+YU7SwCHU0VvDto2vFww+hAYu+ZQ6dQjfIB4
        37nJo+wBc7sKfuwyzX+jnWaHHUhAQw1izo7IArMBXGqDy66+4BETwHowSXzJLrge6hpmb/
        zCEtSBx6A2ScDw5mGWHo2B7MtImxbpE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-nQ8a8A7OPbq_00lIH1D6Ow-1; Fri, 04 Aug 2023 14:25:08 -0400
X-MC-Unique: nQ8a8A7OPbq_00lIH1D6Ow-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe21fda5e3so2402491e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691173507; x=1691778307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fdvxi7T0QQZA7DILvp9xTFYkELtQTf+gq8ZCaeS7cjM=;
        b=TlUXROxglvsFOvEUaXDVBJN1hBKfLNdVzC3eDTEyDNSeSYRpRBFwjnumKj+JktCW+e
         Z2NSk7ynGyNVPCkf1gnetxKFUhgPVWMEaryHA8iliwetXKgYpj3wumYP/91cO6D53eGV
         pOS/laZFWePJyZeXTqfaSefJDg8oSHrKqQZbIv/k+YUsw7r0ANfoe4GF906FXan+DWly
         X3VYKySXkP4/m+rgE7ufknpLs42yHDXnmJrJB/G8dqMymR68NQVEsT5bX+eP1oFf3NTK
         bs+G18HBJgm5ch0Mqt6/gqQ5tf3g+IYuaTy13ms8/KLELh6NmwN5lKYlgITjWlwzpvat
         hLVA==
X-Gm-Message-State: AOJu0YyjGrq5rUW7KlEpnbrGiR4/BEtZL0m76J51XyX95q0UOl3WCfgp
        HaBgKHlWJXfpKIaoOk11M3fb4XBR4VBt++rmOvpAgjtkbtzPV4mYMqiJGjn8+6N86jK9Fjy4Y/m
        CLk20j6QmToFegBdwyFMMsJj8
X-Received: by 2002:ac2:4e8c:0:b0:4fb:7666:3bbf with SMTP id o12-20020ac24e8c000000b004fb76663bbfmr1856026lfr.26.1691173507139;
        Fri, 04 Aug 2023 11:25:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRJJOgbOvJzg5RaLcCj6w1yIpUQozrGAJ91MHogx2h+oZXIcVyODrY21YmNH8oxYAKETecWA==
X-Received: by 2002:ac2:4e8c:0:b0:4fb:7666:3bbf with SMTP id o12-20020ac24e8c000000b004fb76663bbfmr1856008lfr.26.1691173506953;
        Fri, 04 Aug 2023 11:25:06 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id u15-20020a056402064f00b00523228f615dsm486979edx.88.2023.08.04.11.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 11:25:06 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net, donald.robson@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH drm-misc-next v10 12/12] drm/nouveau: debugfs: implement DRM GPU VA debugfs
Date:   Fri,  4 Aug 2023 20:23:52 +0200
Message-ID: <20230804182406.5222-13-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804182406.5222-1-dakr@redhat.com>
References: <20230804182406.5222-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the driver indirection iterating over all DRM GPU VA spaces to
enable the common 'gpuvas' debugfs file for dumping DRM GPU VA spaces.

Reviewed-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 99d022a91afc..053f703f2f68 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -203,6 +203,44 @@ nouveau_debugfs_pstate_open(struct inode *inode, struct file *file)
 	return single_open(file, nouveau_debugfs_pstate_get, inode->i_private);
 }
 
+static void
+nouveau_debugfs_gpuva_regions(struct seq_file *m, struct nouveau_uvmm *uvmm)
+{
+	MA_STATE(mas, &uvmm->region_mt, 0, 0);
+	struct nouveau_uvma_region *reg;
+
+	seq_puts  (m, " VA regions  | start              | range              | end                \n");
+	seq_puts  (m, "----------------------------------------------------------------------------\n");
+	mas_for_each(&mas, reg, ULONG_MAX)
+		seq_printf(m, "             | 0x%016llx | 0x%016llx | 0x%016llx\n",
+			   reg->va.addr, reg->va.range, reg->va.addr + reg->va.range);
+}
+
+static int
+nouveau_debugfs_gpuva(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = (struct drm_info_node *) m->private;
+	struct nouveau_drm *drm = nouveau_drm(node->minor->dev);
+	struct nouveau_cli *cli;
+
+	mutex_lock(&drm->clients_lock);
+	list_for_each_entry(cli, &drm->clients, head) {
+		struct nouveau_uvmm *uvmm = nouveau_cli_uvmm(cli);
+
+		if (!uvmm)
+			continue;
+
+		nouveau_uvmm_lock(uvmm);
+		drm_debugfs_gpuva_info(m, &uvmm->umgr);
+		seq_puts(m, "\n");
+		nouveau_debugfs_gpuva_regions(m, uvmm);
+		nouveau_uvmm_unlock(uvmm);
+	}
+	mutex_unlock(&drm->clients_lock);
+
+	return 0;
+}
+
 static const struct file_operations nouveau_pstate_fops = {
 	.owner = THIS_MODULE,
 	.open = nouveau_debugfs_pstate_open,
@@ -214,6 +252,7 @@ static const struct file_operations nouveau_pstate_fops = {
 static struct drm_info_list nouveau_debugfs_list[] = {
 	{ "vbios.rom",  nouveau_debugfs_vbios_image, 0, NULL },
 	{ "strap_peek", nouveau_debugfs_strap_peek, 0, NULL },
+	DRM_DEBUGFS_GPUVA_INFO(nouveau_debugfs_gpuva, NULL),
 };
 #define NOUVEAU_DEBUGFS_ENTRIES ARRAY_SIZE(nouveau_debugfs_list)
 
-- 
2.41.0

