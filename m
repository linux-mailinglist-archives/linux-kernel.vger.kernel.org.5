Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A7876F020
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjHCQys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjHCQye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AF53C30
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691081606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/Zpw+2MU6XUCAHE50I7yBNOwDhyXO7cbbEk9lEH2AQ=;
        b=R88WvvnH6evsVnJKMLz2Hgaipv8eXbrqk7xYfAhgqGU9FepvSo50ErvBwjYh65zal3eGt2
        Xy00UtIPUzGnlRy5oRoJEfeDwJURjMZwmg6x0roOOAOE2yttOy5vSQiSdS8DC1+tMPyIml
        tSnTnUXT/jmMnQGK+WyVXwMD6h5ODGw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-Xu5flhOaNqCyzVHUTCS7sw-1; Thu, 03 Aug 2023 12:53:25 -0400
X-MC-Unique: Xu5flhOaNqCyzVHUTCS7sw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993831c639aso76302866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691081604; x=1691686404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/Zpw+2MU6XUCAHE50I7yBNOwDhyXO7cbbEk9lEH2AQ=;
        b=XY7IXwL2guTBUor7bqkjguP32bHZqL67HJJl3w1s4UoCkFM/P+MUkXb84hLVfnsVa3
         fM9Wtu9X0TFFYomXiMrTaAC4L1+AIBfEAjPEvt4fgRtXHhPWJz6NMMmUbfk16pdFMObW
         hA6XIT0KZeqCsSPHoNwn4+9RwY8dETLATYXHNyiwi0HCXpb+eXT1DmWZT6zajaf9UKMo
         JC+0LRwuY8rsyZgF2adI19CHNARaz1S4u1xVjtAxt0NrUNZ3yHdfeFn9fxNPSWcfXmkd
         sGbC0mEFxrTmVphscPemRWrqsH1BChHB6Pg2bt9xeV1f3awOgW9RcG9MntNsaIdAoj/9
         x3Kg==
X-Gm-Message-State: ABy/qLajlPdxcsf7B8i5zrOvK6DfzfD6eeWo4uE/W2SBRzRGUY//ONYe
        lunn1JE5gqyNkrT6gzamExqG8rrt5bobxHFqWx7m8zgkE/sBAozusMm7tfVSp7qyuj/kqoJ2cOo
        VXAL9vvRLaMlEWCP4x1MwZQ6Z
X-Received: by 2002:a17:906:845c:b0:99b:cb7a:c16e with SMTP id e28-20020a170906845c00b0099bcb7ac16emr7448800ejy.33.1691081604096;
        Thu, 03 Aug 2023 09:53:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZrPM/Z+NwyCEwlAbDew09S3+m62aBBypP+UWOWz3PIZn/Ob9wE8kk/J55Vhq3fgGvTHyc3w==
X-Received: by 2002:a17:906:845c:b0:99b:cb7a:c16e with SMTP id e28-20020a170906845c00b0099bcb7ac16emr7448793ejy.33.1691081603958;
        Thu, 03 Aug 2023 09:53:23 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ka21-20020a170907991500b009882e53a42csm70527ejc.81.2023.08.03.09.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:53:23 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net, donald.robson@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v9 08/11] drm/nouveau: chan: provide nouveau_channel_kill()
Date:   Thu,  3 Aug 2023 18:52:27 +0200
Message-ID: <20230803165238.8798-9-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803165238.8798-1-dakr@redhat.com>
References: <20230803165238.8798-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new VM_BIND UAPI implementation introduced in subsequent commits
will allow asynchronous jobs processing push buffers and emitting fences.

If a job times out, we need a way to recover from this situation. For
now, simply kill the channel to unblock all hung up jobs and signal
userspace that the device is dead on the next EXEC or VM_BIND ioctl.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c | 14 +++++++++++---
 drivers/gpu/drm/nouveau/nouveau_chan.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index f69be4c8f9f2..1fd5ccf41128 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -40,6 +40,14 @@ MODULE_PARM_DESC(vram_pushbuf, "Create DMA push buffers in VRAM");
 int nouveau_vram_pushbuf;
 module_param_named(vram_pushbuf, nouveau_vram_pushbuf, int, 0400);
 
+void
+nouveau_channel_kill(struct nouveau_channel *chan)
+{
+	atomic_set(&chan->killed, 1);
+	if (chan->fence)
+		nouveau_fence_context_kill(chan->fence, -ENODEV);
+}
+
 static int
 nouveau_channel_killed(struct nvif_event *event, void *repv, u32 repc)
 {
@@ -47,9 +55,9 @@ nouveau_channel_killed(struct nvif_event *event, void *repv, u32 repc)
 	struct nouveau_cli *cli = (void *)chan->user.client;
 
 	NV_PRINTK(warn, cli, "channel %d killed!\n", chan->chid);
-	atomic_set(&chan->killed, 1);
-	if (chan->fence)
-		nouveau_fence_context_kill(chan->fence, -ENODEV);
+
+	if (unlikely(!atomic_read(&chan->killed)))
+		nouveau_channel_kill(chan);
 
 	return NVIF_EVENT_DROP;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/nouveau/nouveau_chan.h
index bad7466bd0d5..5de2ef4e98c2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.h
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
@@ -66,6 +66,7 @@ int  nouveau_channel_new(struct nouveau_drm *, struct nvif_device *, bool priv,
 			 u32 vram, u32 gart, struct nouveau_channel **);
 void nouveau_channel_del(struct nouveau_channel **);
 int  nouveau_channel_idle(struct nouveau_channel *);
+void nouveau_channel_kill(struct nouveau_channel *);
 
 extern int nouveau_vram_pushbuf;
 
-- 
2.41.0

