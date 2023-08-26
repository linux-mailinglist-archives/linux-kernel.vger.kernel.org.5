Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A2B7899A7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 00:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjHZWAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 18:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjHZV77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:59:59 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01539BA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:59:57 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76ef03f76c7so130264585a.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693087196; x=1693691996;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+d25/oRbe7pZrMK6QS9SWtlopgnx8v3V9t4b19GIo6E=;
        b=BtTLFOJhRnTuSw6G2e2ogPuq4gOQaZ3mCHQgwYxJdo2IoSPus4cHtKoBmCpxBfWoHo
         nOud02qlUoGqj5ezB8fY04yGRhiwpGbz3aG5vta/vjpK6NOvFR7iRMeUgVWI19/x6xo4
         vVpj8vNyQbx5NkXT2dmqdW3xplomNR0vj+yWYZnvPIQUddS/HQpjv+Q3U/ZLPaHtb4IB
         i6z4lsKteZ8sYkyNIOhdwlpVaslJSo77FfmHzweI9YGqmgC4VLDWC6npqTPkE3Nrrivr
         AxcfdioZW9zZYhmGgUbyQ5YkZDduflhOmp0SGjl/1a1eO9NZn+a/k3pjNNF1JXoot+kD
         Wh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693087196; x=1693691996;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+d25/oRbe7pZrMK6QS9SWtlopgnx8v3V9t4b19GIo6E=;
        b=G/snLsmd7qlMBwlNEf79OZAh+1ghlOKFy/OUF/zTQsDvmpjpdjowyPH7vas1l96q72
         DL+uJKfqbgp0icyBT8SL55tSPnUaGu9LzaCZyh//xrHTn0EAhyC7fCo6h0tNhrZiqNW9
         uP38cx58dIAo6yLSqpjVOtVosPxS9HlEB7igZFcxaZUKXm8A1yRAbq7WjXLqvkfHI4QU
         nHccWdWgmafWwsCmcwtVuN3SPx0L4I5jJYVmDtFliwj6bB+U2wHDesTAJDwaVXzGy3kn
         kBKl47UqhA3uPPWfNG/CS+MEHjDQkcXdoOobhWl6WWEycV1vEFUf9jl1New30Ml7CWTQ
         KgdQ==
X-Gm-Message-State: AOJu0YxmxQzl+KoaCFO29NWa/EOJafebdptUvyfxTLyDhVbCGOxRq0ua
        A2hJ8EPpqojo4JM2LV4yvk07vrjmWQu6S0iTmOR31xHGZpc=
X-Google-Smtp-Source: AGHT+IEg8o0YHljsGZjksD8nA+PUfXO8XlEI/BvZxU7fVwkrfPXKu7KjivzVjSgOUKFt4fIqmyGfjKAb7lLaMOn5Cr8=
X-Received: by 2002:a05:620a:410b:b0:76e:e68d:149b with SMTP id
 j11-20020a05620a410b00b0076ee68d149bmr13223021qko.50.1693087195923; Sat, 26
 Aug 2023 14:59:55 -0700 (PDT)
MIME-Version: 1.0
From:   Joshua Hudson <joshudson@gmail.com>
Date:   Sat, 26 Aug 2023 14:59:45 -0700
Message-ID: <CA+jjjYTk=5wn2o46uNB+bJYX8xLgMP==dsJuvC94DvtN2f_6Yw@mail.gmail.com>
Subject: Cache coherency bug: stale reads on /dev/sda1
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uname -a
Linux nova 6.4.12 #1 SMP PREEMPT_DYNAMIC Sat Aug 26 09:11:27 PDT 2023
x86_64 GNU/Linux

Kernel source is
https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/linux-6.4.12.tar.xz

Can reliably reproduce as follows:

# hexedit /dev/sda1 (this is my EFI partition)
PgDn
# hexedit /dev/sda
G 100000  (your value may vary--we want to seek to the start of the
EFI partition)
PgDn
PgDn
^C
write a marker to the padding between the BPB and the first FAT sector.
(If your system doesn't have one, edit an error message in the boot sector)
^X
# hexedit /dev/sda1
PgDn
Look for marker written above, find it's not there !!!
^C

I discovered this one trying to defragment my EFI partition after a
grub upgrade left it very fragmented due to replacing logos.
