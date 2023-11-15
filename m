Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18C17ED623
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjKOVhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKOVhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:37:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F50A7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:37:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6A8C433C7;
        Wed, 15 Nov 2023 21:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700084265;
        bh=TFoTHcEUNvXn3HPCw0gAhjtcUPXY2nHk/gab9kxZ9VE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sv7n1QElgb76rqGToIAUTZedLTS/X9qMA6j8l+9hRUdBY0E+pxb/5+Ltz7rkDnIgm
         zaONW59Qxi1ad6w0pkPNwKCkuqvuyEZ6MszSUEsBKesg37khLpOcLkGa8y4OBwsM1Y
         ERXZeEI2P2t2rBRKrjKPjthF4uRmzOYTheF+HgBg=
Date:   Wed, 15 Nov 2023 13:37:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Message-Id: <20231115133743.674690dc78041768b79fadd9@linux-foundation.org>
In-Reply-To: <20231115163018.1303287-2-ryan.roberts@arm.com>
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
        <20231115163018.1303287-2-ryan.roberts@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 16:30:05 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:

> However, the primary motivation for this change is to reduce the number
> of tlb maintenance operations that the arm64 backend has to perform
> during fork

Do you have a feeling for how much performance improved due to this? 

Are there other architectures which might similarly benefit?  By
implementing ptep_set_wrprotects(), it appears.  If so, what sort of
gains might they see?
