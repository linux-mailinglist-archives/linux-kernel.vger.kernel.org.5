Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BCA7A1564
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjIOF1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOF1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:27:42 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6564A271B;
        Thu, 14 Sep 2023 22:27:36 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-791b8525b59so738337241.1;
        Thu, 14 Sep 2023 22:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694755654; x=1695360454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7ix/M53sUnRrSKn9dKsE33ijrUivOY5j8IoNGsWwLLY=;
        b=TEFi5u5g8RXU294s7/LF8MX27YPhlC5ysEgWDdnQ6tZeyioMbi0G5n9Oixnqr3v/fK
         U9k8+9m9BjObcHITlQ2mgDc351z+TJJVhlo4jgrRqA+xz+CnOMVhFtXpKUb/zPJeyPQO
         7qd3bxPvcg6lA6d5XdCg5Y0Rm/LO9Ys2kVHWG9fCPLAfbvpGEZs3m64p2Eeyzrtv1xxu
         E0b0mPc9o6/EdawYvTkRAxRhsIiq9msHgMGchLZma9D/XRWmEevxTVkNSUAUHmuXnq2y
         3KP8jJq7F5Syk3Xdsvyxj45B4ioNH0T1ODtVHzH9gE5YoCJp4gp64PVSsxCP0jdDiIEs
         LQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694755654; x=1695360454;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ix/M53sUnRrSKn9dKsE33ijrUivOY5j8IoNGsWwLLY=;
        b=Z7QGD+lncPAoHY/+3CVm57Wky0WUrxvonZsJDO4Uy4hcyryzx+Kmd4PCap27yCXRrQ
         Swtr7CGCq8eTKI36PdzGOwwBWJNvOSfF1XnYZtsoTKWENgeDKIVPgjvd2dZKIKOcnoOF
         dAV5rWEQIbFcSSX1/Cdne8LOMmyUSGcxx/mHZB8B0NsKHlzUHdphdmOs95CrgZ/aJgDY
         RWuiPo5oXVQAUtzvEJzCQC+9lfmUktBNyt0PEu/D4r59bHcS984k/jQ4ObHpSqwKed6/
         B9UKa6JO0UKwZvuT5HhGIXrJBM601TqfIBJ4V0pe3oF2mAMjGz4fBqkj4P8ODWKaRmd8
         8YDQ==
X-Gm-Message-State: AOJu0YxDL/bnGAokDHcpsxva94/LKq/hQuHSmjho+NqcsMfKni20P/os
        ww/vigbDYcJwqbmMkxI7XAejREb1pKUOCriCz+OA+dVvr6E=
X-Google-Smtp-Source: AGHT+IGKmVhyUn+vsHoF4VECMDL1zQcWfxE84Z3naWLFEm7QjOTkP3CBJqIlGS4zsvfxvvtZZGCMhG1fuJeW0drOqKQ=
X-Received: by 2002:a1f:e082:0:b0:495:cace:d59c with SMTP id
 x124-20020a1fe082000000b00495caced59cmr747710vkg.0.1694755654556; Thu, 14 Sep
 2023 22:27:34 -0700 (PDT)
MIME-Version: 1.0
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Thu, 14 Sep 2023 22:27:22 -0700
Message-ID: <CACsaVZ+LkHwTKO4XE_FFM62SbF3gGD4DZyse-9Y1UbJUgrhvfA@mail.gmail.com>
Subject: Linux 6.1.52 regression: Intel QAT kernel panic (memory corruption)
To:     Linux-Kernal <linux-kernel@vger.kernel.org>, qat-linux@intel.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Intel QAT Maintainers,

It looks like QAT has regressed again. The present symptom is just
straight up memory corruption. I was running Canonical 6.1.0-1017-oem
and it doesn't happen, with 6.1.0-1020-oem and 6.1.0-1021-oem it does.
I don't know what these map to upstream, however with NixOS installed
the same corruption failure occurs on 6.1.52. The stack traces give
illegal instructions and all kinds of badness across all modules when
the device is simply present on the system, resulting in a hung
system, or a multitude of processes crashing and the system failing to
start. Disabling the device in the system BIOS results in a working
system, and no extreme corruption. kmem_cache_alloc_node is the common
fixture in the traces (I don't have a serial line), but I suspect
that's not where the problem is. The corruption this time happens
without block crypto being involved, and simply booting the installer
from a USB stick.

I genuinely do not understand how this keeps breaking in these
critical contexts completely hosing the machine. I was under the
impression it was disabled on this box the entire time since the last
run-in with this, but it must have gotten flipped back on when I did a
firmware update back in December 2022.

Kyle.
