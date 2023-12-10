Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C3A80BA0F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjLJJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 04:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjLJJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 04:54:43 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E5D9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 01:54:49 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9f559b82cso39210701fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 01:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702202087; x=1702806887; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SBN5V2xM9cTtPQfPukDl8dzX6O5lxBQp1fRUUmCSAFA=;
        b=IUU2vAOgzVALJVjzZQOyg6n1qYUm5qgxIYfFC8nIG94CJBeqWpGHjdgmowOS8xeUZm
         GiduzRd+acYP9o7YrfghWn2CV659PhjIafsGqBp9pv25Ooh/tjegh1Ckz0fqOA5S/iOH
         XhDeM0NlXEPmiIUornvBwLSyQBzyUDpd2Da4Rze3dvgPgYp4tctbJ3CtUgwpry7twAG0
         hQ1t3xDD97oGUgOVIT9KqVWymF+eR911WSXPetCYXM44BFPM2GTnNozTveYoid1mss7L
         JE8fXEgDz8jZt5N8JcQYyiNnnzeZhE7Bs7HUEyYOTSgImN/CMhgZgyMM4dnGlVG9VnzO
         1uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702202087; x=1702806887;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBN5V2xM9cTtPQfPukDl8dzX6O5lxBQp1fRUUmCSAFA=;
        b=sFY6zXToHdvo3GEsJO+V+Scsr79C5VXUHogGNDjgFMeTvoe2/1QK8pzm292kv4SKZc
         dcK/8TLY6HkUIOZiue/hnwoXAefqbOfC27C6U18WjQ2NOobzr3cdaarze3m68ZmGpBLn
         SHskOQolWkzRCMH+OblX9ISxahDnafwxW71O9WSSBDTpj0P1KfaNWTtBBivn7YnLIPzT
         uT1peyZBwmnbdy+ax5W6dpWUMhoo4DhuTieAJCtLbrLV0TIHPuiM2HcTw6ouIXGMDcbT
         hzXrZbO7nXz+Bc+ZnuanWSVx8YAL53riupP2+Bcv6vxLvNlNB/8LsQFdDURcfEa/Mdn/
         khNw==
X-Gm-Message-State: AOJu0YxoU4dou5lXZs9l8xrHxGvJigDrm8G5HKVcUOCyy3jJ4CUZR3Mt
        rPSPtp6UVME3RlbYvIJm8ptG+s2iwWio4GNiDZLkd2/Yz/I=
X-Google-Smtp-Source: AGHT+IFDXFYENua0LUaZqk7cxev6KH3AGPyIpjKDeMUfSmF00kLWh3vKhG5yWi35ymD5gMHDsWBwX3j8nAzpYKs5TcI=
X-Received: by 2002:a2e:8796:0:b0:2ca:fb6:e732 with SMTP id
 n22-20020a2e8796000000b002ca0fb6e732mr925845lji.49.1702202086910; Sun, 10 Dec
 2023 01:54:46 -0800 (PST)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sun, 10 Dec 2023 15:24:34 +0530
Message-ID: <CAHP4M8WHcDABX-Vwr6kndoFTJKA7Sd3euruabDfXw6SfeqOObw@mail.gmail.com>
Subject: Preemption VS Interrupts
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

The API "spin_lock" disables preemption on the local processor.
The API "spin_lock_irqsave" disables preemption on the local
processor, and also disables interrupts on the local processor.

Thus, is disabling-interrupt independent of preemption?
In other words, can an interrupt still "preempt" a critical section
code even if preemption is disabled in the general sense (on a
non-preemptive kernel for example)?


Will be grateful for help in this regard, as it will clear up the
fuzziness going in my head.
Many thanks in advance !


Thanks and Regards,
Ajay
