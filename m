Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB2C790265
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350291AbjIATGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjIATGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:06:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC524E56
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:06:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693595191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iOvRrs8LC47Td5buc7O8tH5aMDvXvb/5pEyTYE41830=;
        b=21+p+HQ4yVVCMfRdYG4q9ZQaIb5AqSTgee5OZ6oMZiLI19llY4xylNK3KKPkIOtxftZYaT
        El0BQYah5pa6B4J0PspRXCPM6CdhUnmSwc5e7Y2JQb5KIXSqC/FnyLqRwJJ89n6eBjOxCR
        Da+QQ187nR55LRXG5fDh7i4rg4hskdXRYz4hxSlD1qSVz0c7RakX94EN7wS6S4soUh0ebN
        6yzNdI3tWj+5CM+qd3xofTybIPe2bBULS+euwtmfIzei9tEHWoZRqS3RiFjq/WuMLZCMYV
        IF329GIhYs9+6JBtq1JRGvQMxxSlEZLzPzp8FwgZ5smnWbBGB+AyYCZSexC+bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693595191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iOvRrs8LC47Td5buc7O8tH5aMDvXvb/5pEyTYE41830=;
        b=MKdDuSWC1h802HQ/TlAhAvDNEaK39ASYy+mTuH9F8HCi59dwAMamEqmPZOQqS7/aC/6TQg
        oewy19hXq1SGjdAA==
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] configfs-tsm: Introduce a shared ABI for
 attestation reports
In-Reply-To: <169342400469.3934343.12316161608372095860.stgit@dwillia2-xfh.jf.intel.com>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342400469.3934343.12316161608372095860.stgit@dwillia2-xfh.jf.intel.com>
Date:   Fri, 01 Sep 2023 21:06:31 +0200
Message-ID: <877cp94sso.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30 2023 at 12:33, Dan Williams wrote:
>
> Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> Link: http://lore.kernel.org/r/57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com [2]
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Nice!

Acked-by: Thomas Gleixner <tglx@linutronix.de>
