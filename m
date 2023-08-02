Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DFB76D00B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjHBO2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjHBO2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:28:00 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC201728;
        Wed,  2 Aug 2023 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690986479; x=1722522479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p/SGJRV93Cj6BkuM7fuzVQ4z+KIw1N5smHREmEpUMUg=;
  b=T+apWSPdyK+p0TBkR1pHIvn4pke3d3m0oYsqGhPeWwYR5J/UW2A0O3tq
   syoJ686Ut+OAW8n/N+aWiTT1MYVP2jh8/jMb7kjRpP2Xvo+hTIOmMkNmy
   V63XXLIWKGg6a/Reek0vuvMypZPB3c7iN7KT+1LGxocGidhrVuK6XTxIc
   uG3lkkBkGisy018QAUNwR+pbg0dVyK/LXtVzVFUTIooDI0SyROlLdqS06
   MwaMAeta1ZOQEWXLq6Y5VouEg3G6j10kW2gin8oJdwiNlOzxkIaZx2Edt
   Ylc+wsaq4SFfsx6Ts/UVz7cjsx0VQWMSZo1Wbf8GOYWxgnV3Jd9RvBSdQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="435922197"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="435922197"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 07:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="706200507"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="706200507"
Received: from rbstewar-mobl1.amr.corp.intel.com (HELO [10.212.249.107]) ([10.212.249.107])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 07:20:22 -0700
Message-ID: <bc950efd-b7f7-5fc9-b41d-ebddcf4a459e@intel.com>
Date:   Wed, 2 Aug 2023 07:20:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] crypto: Zhaoxin: Hardware Engine Driver for
 SHA1/256/384/512
Content-Language: en-US
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        seanjc@google.com, kim.phillips@amd.com, peterz@infradead.org,
        pbonzini@redhat.com, pawan.kumar.gupta@linux.intel.com,
        babu.moger@amd.com, jiaxi.chen@linux.intel.com,
        jmattson@google.com, sandipan.das@amd.com,
        linux-crypto@vger.kernel.org
Cc:     CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com
References: <20230802110741.4077-1-TonyWWang-oc@zhaoxin.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230802110741.4077-1-TonyWWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code looks pretty rough.

> +static int zhaoxin_sha1_update(struct shash_desc *desc,
> +			const u8 *data,	unsigned int len)
> +{
> +	struct sha1_state *sctx = shash_desc_ctx(desc);
> +	unsigned int partial, done;
> +	const u8 *src;
> +	/*The PHE require the out buffer must 128 bytes and 16-bytes aligned*/
> +	u8 buf[128 + ZHAOXIN_SHA_ALIGNMENT - STACK_ALIGN] __attribute__
> +		((aligned(STACK_ALIGN)));
> +	u8 *dst = PTR_ALIGN(&buf[0], ZHAOXIN_SHA_ALIGNMENT);

All of the different alignments here are pretty dazzling.

> +	partial = sctx->count & 0x3f;

"0x3f" is a random magic number.

> +	sctx->count += len;
> +	done = 0;
> +	src = data;
> +	memcpy(dst, (u8 *)(sctx->state), SHA1_DIGEST_SIZE);
> +
> +	if ((partial + len) >= SHA1_BLOCK_SIZE) {
> +
> +		/* Append the bytes in state's buffer to a block to handle */
> +		if (partial) {
> +			done = -partial;
> +			memcpy(sctx->buffer + partial, data,
> +				done + SHA1_BLOCK_SIZE);
> +			src = sctx->buffer;
> +			asm volatile (".byte 0xf3,0x0f,0xa6,0xc8"
> +			: "+S"(src), "+D"(dst)
> +			: "a"((long)-1), "c"(1UL));

Please look around the codebase for examples on how to do this.  We
usually try to use real instructions when binutils supports them and
also don't repeatedly open-code the ".byte ...".

> +			done += SHA1_BLOCK_SIZE;
> +			src = data + done;
> +		}
> +
> +		/* Process the left bytes from the input data */
> +		if (len - done >= SHA1_BLOCK_SIZE) {
> +			asm volatile (".byte 0xf3,0x0f,0xa6,0xc8"
> +			: "+S"(src), "+D"(dst)
> +			: "a"((long)-1),
> +			"c"((unsigned long)((len - done) / SHA1_BLOCK_SIZE)));
> +			done += ((len - done) - (len - done) % SHA1_BLOCK_SIZE);
> +			src = data + done;
> +		}
> +		partial = 0;
> +	}
> +	memcpy((u8 *)(sctx->state), dst, SHA1_DIGEST_SIZE);

What's the purpose of the cast?

> +	memcpy(sctx->buffer + partial, src, len - done);
> +
> +	return 0;
> +}
> +
> +static int zhaoxin_sha1_final(struct shash_desc *desc, u8 *out)
> +{
> +	struct sha1_state *state = (struct sha1_state *)shash_desc_ctx(desc);

What's the purpose of *this* cast?

> +	unsigned int partial, padlen;
> +	__be64 bits;
> +	static const u8 padding[64] = { 0x80, };
> +
> +	bits = cpu_to_be64(state->count << 3);
> +
> +	/* Pad out to 56 mod 64 */
> +	partial = state->count & 0x3f;
> +	padlen = (partial < 56) ? (56 - partial) : ((64+56) - partial);
> +	zhaoxin_sha1_update(desc, padding, padlen);
> +
> +	/* Append length field bytes */
> +	zhaoxin_sha1_update(desc, (const u8 *)&bits, sizeof(bits));
> +
> +	/* Swap to output */
> +	zhaoxin_output_block((uint32_t *)(state->state), (uint32_t *)out, 5);
> +
> +	return 0;
> +}
> +
> +static int zhaoxin_sha256_init(struct shash_desc *desc)
> +{
> +	struct sha256_state *sctx = shash_desc_ctx(desc);
> +
> +	*sctx = (struct sha256_state){
> +		.state = { SHA256_H0, SHA256_H1, SHA256_H2, SHA256_H3,
> +				SHA256_H4, SHA256_H5, SHA256_H6, SHA256_H7},
> +	};
> +
> +	return 0;
> +}
> +
> +static int zhaoxin_sha256_update(struct shash_desc *desc, const u8 *data,
> +			  unsigned int len)
> +{
> +	struct sha256_state *sctx = shash_desc_ctx(desc);
> +	unsigned int partial, done;
> +	const u8 *src;
> +	/*The PHE require the out buffer must 128 bytes and 16-bytes aligned*/
> +	u8 buf[128 + ZHAOXIN_SHA_ALIGNMENT - STACK_ALIGN] __attribute__
> +		((aligned(STACK_ALIGN)));
> +	u8 *dst = PTR_ALIGN(&buf[0], ZHAOXIN_SHA_ALIGNMENT);
> +
> +	partial = sctx->count & 0x3f;
> +	sctx->count += len;
> +	done = 0;
> +	src = data;
> +	memcpy(dst, (u8 *)(sctx->state), SHA256_DIGEST_SIZE);

That looks familiar.

This patch needs some serious cleanups and refactoring.  It seems to be
missing even the basics like avoiding copy-and-pasting code.  The
changelog is quite sparse.

Could you spend some more time on this and give it another go, please?
