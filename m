Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8DB7FF92A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjK3SOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346092AbjK3R0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:26:09 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C90C1729
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:26:15 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso1095657276.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701365174; x=1701969974; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ZkkWHMYcFVuZYJuBjFNLyS0R8D8QJNJTax65ZVU/Fc=;
        b=i3/PsF2Sxeh+SJt5YTDbD72Ue0eZXA1xJLbQ5c5MEMjf6VMjdzkaWrnFwUBdrOcobh
         ehLaT6GcZdLhymW6bNBrMIeNgYGsFoZ0omVIprjMU3WggSzoJ5grJEQ9ZbJY8fyo65jW
         z6Giq7PINDytX61t4v6VSS6lkHn/bTmJ2TmaNwA1YZxHzJNrcAv42s5mscUnL4TGQt9O
         En1chH3cS3JRuLJOYHs78zIim94MDARgh/ivSAOqJaVPH73A4DfIbYTw7zZ5M+uNtrv1
         UxiWTh3rudXsOx13kJFgdlsR6k8NnLf6tiF5dbqbJpz/czdLDQ3BC/FvveGIisoXHLwY
         X8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365174; x=1701969974;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZkkWHMYcFVuZYJuBjFNLyS0R8D8QJNJTax65ZVU/Fc=;
        b=VPkYpvetS3URExfyLry4R+GD1cJLkUXPFJMECR1i0t88RfJwL4kS2BBdiYuFwzlQd6
         l6+EdKmocdGHhCgA1oZEQl9lVQy/q5WAX5ip3dwQATjH0NNAmuX9TTMAgolJEyHbm6jD
         OXgTzael857MAcn/40qDC4sXz5+I3+Lb4b1ZtNSR/+oQYgU3CG7fULDlXslMkp7Ps2g0
         1Tid1euygMiwsjxeF/gAo/zq3qVQYlGb/f7axKlKX6YPlSTch9JbOIuY5dCpVkDZBvhf
         DiSDlOHMMJac45ngWhRsDew5ORz/hsPihg3DX85kI48QwCgnxYzeuObdL+WqLe04JLlt
         OLNQ==
X-Gm-Message-State: AOJu0YwS3i2dj8E9dAQr2POHRHX7L98Gw1W4zj7xl4ZsC+KbqKLvlHi+
        YRhB9Z277w2BrAbZAd0IGKA0jIeBvEQ3wShPlW5U3cmFyiMGSPct
X-Google-Smtp-Source: AGHT+IEgflwddcckdtau1Jwz4SF50QqOh4QZyUPjXWBL6v4jPNlgytgNY7T1mCYNLwmxEXQwIuOvgBy1qsVUiRjObrQ=
X-Received: by 2002:a81:9a4e:0:b0:5d3:a274:c77b with SMTP id
 r75-20020a819a4e000000b005d3a274c77bmr1246625ywg.5.1701365174560; Thu, 30 Nov
 2023 09:26:14 -0800 (PST)
MIME-Version: 1.0
From:   Alexandru Goia <goia.i.alexandru@gmail.com>
Date:   Thu, 30 Nov 2023 19:25:35 +0200
Message-ID: <CADmgqai5Ohnnq9G3Sm87pujtD3iMcUwGEqpLds2nDQroXgNxeg@mail.gmail.com>
Subject: Linux 4 block device driver infrastructure
To:     linux-kernel@vger.kernel.org, linux-kernel@lore.kernel.org
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

Greetings !

I am a Unix/Linux hobbyist from Romania, interested in kernel stuff.
I need some clarifications, related to block device subsystem in Linux 4,
so I will ask them here, if you can answer me, please...

1) Why (in Linux 4) in struct block_device_operations, the
(*open)(struct block_device *, fmode_t)
has a different signature than the (*release)(struct gendisk *,
fmode_t) ? Why open()
uses block_device, while release() uses gendisk ? They are both in a struct
block_device_operations. Why they not refer to the same thing ?

I understand that gendisk refer to a real disk, and block_device (s)
to logical disk (s)
and partitions. But why the kernel developers have chosen to use
different signatures ?

2) Release() is also synonim to close() ?
3) Why is not explicitely present a close() function ?
4) Why struct gendisk does not have inside it pointers to struct block_device ?

Thank you very much,
Alexander,
Computer hobbyist,
Romania

Please answer also to my personal address : <goia.i.alexandru@gmail.com>
