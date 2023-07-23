Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D6175E5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGWWzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGWWzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:55:19 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDF51B7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:55:19 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6b9d16c1f3bso3398256a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690152918; x=1690757718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUHzU2F2eAFVsc/O9Q7E+gnv1debu/0OoQduFE4zLvQ=;
        b=Q8h+O1U6KS7chZt6JwRrmfKYKk098ovzIdfXxygl1UTfqrvaQJxB6VZxk4HazI8Rsu
         BMcSJDDqrp5upN/ZGtdGB6RlJZDWdHqzDps58Ez5g1PHnB3XXVw3x3vrUhQTJ5yYNZ6B
         ptOncPB6ral/39plX20wFsOjZ8TSW3GQGH4gqd4h1jFohdCsIdTQirAMwBoRn6D/tgfG
         3Lls+3k0ovcDEnmt8s7CZv13J83sicFEaG5NDZEe5tMDT0BeyHDEbWR6ly+9CgpTgwnO
         JFswBIQxWsUv0tKzqBilIHq9H1bk+6NKR7z3T9SfkF+ZWjskRISIWV5KmujI21I+u0+V
         CjUQ==
X-Gm-Message-State: ABy/qLYEnSjnInk/F8LN+CCvFZw0gAWxBBqaesPy2yW4T9ZggPAbk8Bq
        924AOf3zolu61Om5+SnarD0=
X-Google-Smtp-Source: APBJJlF/ug0ThZGhnKznWZAy0KS8g9loTF7zoqWL+EgGWJkarSD6tOJIuyPncnfUj0pwbpbY6fZ1SQ==
X-Received: by 2002:a9d:4f19:0:b0:6b9:68fb:5a28 with SMTP id d25-20020a9d4f19000000b006b968fb5a28mr6669400otl.27.1690152918346;
        Sun, 23 Jul 2023 15:55:18 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id jh11-20020a170903328b00b001bb3beb2bc6sm133349plb.65.2023.07.23.15.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 15:55:17 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:55:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 52/58] x86/apic: Replace acpi_wake_cpu_handler_update()
 and apic_set_eoi_cb()
Message-ID: <ZL2v1HvtmPVZxmGf@liuwe-devbox-debian-v2>
References: <20230717223049.327865981@linutronix.de>
 <20230717223226.178478466@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717223226.178478466@linutronix.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:15:55AM +0200, Thomas Gleixner wrote:
> Switch them over to apic_update_callback() and remove the code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
