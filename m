Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E588768F41
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjGaH40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGaH4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:56:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F44199;
        Mon, 31 Jul 2023 00:56:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E4071F74C;
        Mon, 31 Jul 2023 07:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690790181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pIov8vVMxRXk3LyFbp2uD7LCYfJdh0gTq4UHYD1FInU=;
        b=IHnIUQZ9tVD/LASVC7rY1vGfrWL9+ec7o+rPfms6OJLNDzTNPC7aHi2M1nuiRuDQBze+ae
        O6dfZ19xVe75ZjC34nC+0+XdIcwq2HDvK2VBrnkVsPk9667dBBwoStRKrxzy5OgV8bSNNv
        3q/hDsaIvRA3ATqfO4tWSmdMITxBmUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690790181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pIov8vVMxRXk3LyFbp2uD7LCYfJdh0gTq4UHYD1FInU=;
        b=eztUAdxg5V1WceeZeOx6eIIrl61kMJVZKqLNYceVCOHCR0LVSeE9S4r4QUicyJF3kjz1K5
        P0bcigSCk9jJCFAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E45F1133F7;
        Mon, 31 Jul 2023 07:56:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MQfqNiRpx2RNEAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 31 Jul 2023 07:56:20 +0000
Message-ID: <e4f7ae0c-5397-4b20-80e8-6c0baece3e8c@suse.cz>
Date:   Mon, 31 Jul 2023 09:56:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] rust: allocator: Prevent mis-aligned allocation
To:     Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Andreas Hindborg <nmi@metaspace.dk>
References: <20230730012905.643822-1-boqun.feng@gmail.com>
 <20230730012905.643822-2-boqun.feng@gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230730012905.643822-2-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/23 03:29, Boqun Feng wrote:
> Currently the rust allocator simply passes the size of the type Layout
> to krealloc(), and in theory the alignment requirement from the type
> Layout may be larger than the guarantee provided by SLAB, which means
> the allocated object is mis-aligned.
> 
> Fix this by adjusting the allocation size to the nearest power of two,
> which SLAB always guarantees a size-aligned allocation. And because Rust
> guarantees that the original size must be a multiple of alignment and
> the alignment must be a power of two, then the alignment requirement is
> satisfied.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Co-developed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
> Signed-off-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: stable@vger.kernel.org # v6.1+

Acked-by: Vlastimil Babka <vbabka@suse.cz>

