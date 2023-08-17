Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2947677FD10
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354031AbjHQReI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354032AbjHQReE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:34:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418B4210D;
        Thu, 17 Aug 2023 10:34:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:dffa:9883:e232:5c72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C2DFE20BC;
        Thu, 17 Aug 2023 17:34:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C2DFE20BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1692293641; bh=JOy8tw23GbqTzI989JJ+ZmQljWwQRjDrUvKtHWBanzU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rhP8QvPTw6jrY8+OGf8yEX9dWu8OEPNsZ3wvrAfPUwYGpU5ajAMDBmzIVhgPEQae8
         Csaj7xOK7KqCIohN1x0HMJb/zrHKopAACId7WadNmtaZ/+MwgoRaZMRhU9b/askFSr
         90iI5lgW/HE8lY4dLaMWmy6HEjAFdHfixGbl03EKq6OqDDeedz+I8sPEa6nY4n2Z0w
         IyPjRhmp9mWrIPzhSXqW8KA4oHnL9c+0rE4YrZqQPt4B5c8cc3GoUnDlPMYCUFnQoe
         9q28dnN4vmQ2bwmy56j+ez1zMqYo47Z6/UzUeyMn7f8WtEIgYHymdEwAGp2XH96Ac0
         o06/1KukDywJQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-doc@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Deming Wang <wangdeming@inspur.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3] Documentation/highmem: Add information about
 kmap_local_folio()
In-Reply-To: <2898756.e9J7NaK4W3@suse>
References: <20230708121719.8270-1-fmdefrancesco@gmail.com>
 <87r0paxooq.fsf@meer.lwn.net> <2898756.e9J7NaK4W3@suse>
Date:   Thu, 17 Aug 2023 11:34:00 -0600
Message-ID: <87350h375j.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Fabio M. De Francesco" <fmdefrancesco@gmail.com> writes:

> On venerd=C3=AC 14 luglio 2023 21:45:09 CEST Jonathan Corbet wrote:
>> "Fabio M. De Francesco" <fmdefrancesco@gmail.com> writes:
>> > The differences between kmap_local_page() and kmap_local_folio() consi=
st
>> > only in the first taking a pointer to a page and the second taking two
>> > arguments, a pointer to a folio and the byte offset within the folio w=
hich
>> > identifies the page.
>> >=20
>> > The two API's can be explained at the same time in the "Temporary Virt=
ual
>> > Mappings" section of the Highmem's documentation.
>> >=20
>> > Add information about kmap_local_folio() in the same subsection that
>> > explains kmap_local_page().
>> >
>>
> [snip]
>>=20
>> Applied, thanks.
>>=20
>> jon
>
> Jonathan,
>
> Can you please tell me which release is this patch for? I see that it has=
 not=20
> yet reached upstream.

It's in docs-next and will go to Linus during the merge window.

Thanks,

jon
