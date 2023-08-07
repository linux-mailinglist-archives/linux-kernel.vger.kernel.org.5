Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22661771923
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 06:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjHGErJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 00:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjHGErD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:47:03 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099C310FA;
        Sun,  6 Aug 2023 21:47:03 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-54290603887so2294383a12.1;
        Sun, 06 Aug 2023 21:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691383622; x=1691988422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zvtqBUA/rv8KyjjXbQs1LZot+zI2l/+/ZBdQdR25eQ=;
        b=e+qBvbYw3xYTjBT2APiV3rgWoUTnofyGHfLbksTbLGX9TM2T9luCaU6cO5FkkNUe/y
         Nv6b1cfKnleYoP3DNi5nevFyec5SfIJs2Sw5qOjQmcuG2nuh7HUKRKRkQRvb87WDzYMQ
         Qgkdb+5f/wny+pedkW9pUYq0hjF5MMTeNqWKI/X/N+sRybKinb77WKhSowlSwKuv13Rp
         FGVE2Jnryu/iscXwqeqyiO/8I/xhNGd++RZ2M8Y3FkPUbDUF7w0vIVbtvxqn41ixOcou
         N2IFIiN0kgmzqA+k+ydvd8PDl0rpvucaNaqaxQPZ1DBCZxz5N8VdMWS2DDd6H/PN32t6
         OA2Q==
X-Gm-Message-State: AOJu0YwvQhG2lAdX3y6i+FOYWWBZ3iU4iV4accEfpT3t8dn5Qdrkdu8m
        ePb3xSkvjQ+qI4Sl9Tpzm5E=
X-Google-Smtp-Source: AGHT+IGpuzqJ82grMLK+t12qrXr5CsN04rw5jPU7Yh4Jq89x7rOsvEQ1ZU6gU8BEgKfB70TojIVijA==
X-Received: by 2002:a17:903:41d1:b0:1a9:40d5:b0ae with SMTP id u17-20020a17090341d100b001a940d5b0aemr8795424ple.12.1691383622463;
        Sun, 06 Aug 2023 21:47:02 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001b9ecee9f81sm5735515plb.129.2023.08.06.21.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 21:47:02 -0700 (PDT)
Date:   Mon, 7 Aug 2023 04:46:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the hyperv tree
Message-ID: <ZNB3PXgIBvJhiEu1@liuwe-devbox-debian-v2>
References: <20230807142238.50616687@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807142238.50616687@canb.auug.org.au>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 02:22:38PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hyperv tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/pci/controller/pci-hyperv.o: warning: objtool: .altinstr_replacement+0x0: weirdly overlapping alternative! 11 != 6
> drivers/hv/hv_balloon.o: warning: objtool: .altinstr_replacement+0x0: weirdly overlapping alternative! 11 != 6
> drivers/hv/hv_vmbus.o: warning: objtool: .altinstr_replacement+0x3: weirdly overlapping alternative! 10 != 5
> vmlinux.o: warning: objtool: .altinstr_replacement+0x633: weirdly overlapping alternative! 11 != 6
> incomplete ORC unwind tables in file: vmlinux
> Failed to sort kernel tables
> 
> I have no idea what caused this.
> 

/me scratches head.

> I have used the hyperv tree from next-20230804 for today.

I've reverted that series from my tree. Thanks for the heads up.

Thanks,
Wei.
