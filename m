Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF0C79FD2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjINHXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjINHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:23:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31823EB;
        Thu, 14 Sep 2023 00:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hs/mlrv/eD2SwujsRiTBYolASJjx6pMkxI5K0cdgMDA=; b=TyfwmW+/rybQiNn0YGJZGA+wgJ
        0d4MZ8LjmZuu/yBmBsXLD+zG7SvnjG3X/03+3no7cxT+yKu8AdAn5IUsaw8on/9P7Yz0nj7BOoLJM
        uQrxd3np3ihsAHEThutLjwGHwiLetm+bt8tJsfMdQXx+QHDSkBdbGCG0+IPsb3bt3PZujWlUumvzx
        lK/malGVFD2z5hRqjl9W2caRyrD4edOKG8CmnlX5T8doFee20111WW0JJTg23A/O0ga3Bq2u0lFQU
        Z2nsLR3L8BREhk3MhrarYV4BR5dxa1rna7STVEEi2G+UzyYTL6MftFY54VJ02T8ctbzLW8ewcA051
        ji4q7U+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgghC-007hbk-1g;
        Thu, 14 Sep 2023 07:23:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1EB330036C; Thu, 14 Sep 2023 09:23:27 +0200 (CEST)
Date:   Thu, 14 Sep 2023 09:23:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        matz@suse.de
Subject: Re: linux-next: Tree for Sep 13 (objtool)
Message-ID: <20230914072327.GB16631@noisy.programming.kicks-ass.net>
References: <20230913150445.49bee094@canb.auug.org.au>
 <a53f9840-8581-44cc-beaf-6fb644c8cacc@infradead.org>
 <20230913214753.3xqemkqjhxcwqaz4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913214753.3xqemkqjhxcwqaz4@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Sep 13, 2023 at 11:47:53PM +0200, Josh Poimboeuf wrote:
> On Wed, Sep 13, 2023 at 01:34:11PM -0700, Randy Dunlap wrote:
> > 
> > 
> > On 9/12/23 22:04, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20230912:
> > > 
> > > The bpf-next tree (I think) gained a boot time warning due to a semantic
> > > interaction with changes in the bpf tree.
> > > 
> > > The drm-misc tree gained a conflict against Linus' tree.
> > > 
> > > Non-merge commits (relative to Linus' tree): 4427
> > >  1907 files changed, 354449 insertions(+), 27039 deletions(-)
> > > 
> > > ----------------------------------------------------------------------------
> > 
> > on x86_64:
> > 
> > drivers/media/common/siano/smscoreapi.o: warning: objtool: .text.unlikely: unexpected end of section
> > 
> > Full randconfig file is attached.
> 
> Objtool is correct:
> 
>   Disassembly of section .text.unlikely:
> 
>   0000000000000000 <smscore_set_device_mode.cold>:
>      0:   48 83 05 00 00 00 00 01         addq   $0x1,0x0(%rip)        # 8 <__UNIQUE_ID___addressable_smscore_unregister_client433>       3: R_X86_64_PC32        .bss+0xa03
> 
> It's not really a functional bug, it's just gcov somehow keeping GCC
> from finishing an optimization.
> 
> In smscore_load_firmware_from_file(), which gets inlined by
> smscore_set_device_mode(), GCC is smart enough to know that
> 
>   'coredev->device_flags & SMS_DEVICE_FAMILY2'
> 
> is always true, so it half-optimizes out the ':' condition:
> 
> 		rc = (coredev->device_flags & SMS_DEVICE_FAMILY2) ?
> 			smscore_load_firmware_family2(coredev, fw_buf, fw_buf_size)
> 			: loadfirmware_handler(coredev->context, fw_buf,
> 			fw_buf_size);
> 
> Though it actually still keeps the branch.  It goes to
> smscore_set_device_mode.cold so it can set the GCOV "branch taken" bit
> for the !SMS_DEVICE_FAMILY2 case.  But then it just falls off the edge
> off .text.unlikely.
> 
> Peter, any opinions how to handle this?

Ask the GCC people to not do this? :-)

> We could just make smscore_load_firmware_from_file() noinline.
> 
> Or we could hard-code the fact that smscore_load_firmware_from_file() is
> only called in the SMS_DEVICE_FAMILY2 case, like:

Yeah, this seems simplest. The code in question doesn't seem overly
complicated and we can simply avoid confusing GCC.

> diff --git a/drivers/media/common/siano/smscoreapi.c b/drivers/media/common/siano/smscoreapi.c
> index 7d4bc2733f2b..58d951903e93 100644
> --- a/drivers/media/common/siano/smscoreapi.c
> +++ b/drivers/media/common/siano/smscoreapi.c
> @@ -1127,19 +1127,19 @@ static char *smscore_get_fw_filename(struct smscore_device_t *coredev,
>   * @param coredev pointer to a coredev object returned by
>   *                smscore_register_device
>   * @param filename null-terminated string specifies firmware file name
> - * @param loadfirmware_handler device handler that loads firmware
>   *
>   * return: 0 on success, <0 on error.
>   */
>  static int smscore_load_firmware_from_file(struct smscore_device_t *coredev,
> -					   int mode,
> -					   loadfirmware_t loadfirmware_handler)
> +					   int mode)
>  {
>  	int rc = -ENOENT;
>  	u8 *fw_buf;
>  	u32 fw_buf_size;
>  	const struct firmware *fw;
>  
> +	BUG_ON(coredev->device_flags != SMS_DEVICE_FAMILY2);
> +
>  	char *fw_filename = smscore_get_fw_filename(coredev, mode);
>  	if (!fw_filename) {
>  		pr_err("mode %d not supported on this device\n", mode);
> @@ -1147,10 +1147,6 @@ static int smscore_load_firmware_from_file(struct smscore_device_t *coredev,
>  	}
>  	pr_debug("Firmware name: %s\n", fw_filename);
>  
> -	if (!loadfirmware_handler &&
> -	    !(coredev->device_flags & SMS_DEVICE_FAMILY2))
> -		return -EINVAL;
> -
>  	rc = request_firmware(&fw, fw_filename, coredev->device);
>  	if (rc < 0) {
>  		pr_err("failed to open firmware file '%s'\n", fw_filename);
> @@ -1166,10 +1162,7 @@ static int smscore_load_firmware_from_file(struct smscore_device_t *coredev,
>  		memcpy(fw_buf, fw->data, fw->size);
>  		fw_buf_size = fw->size;
>  
> -		rc = (coredev->device_flags & SMS_DEVICE_FAMILY2) ?
> -			smscore_load_firmware_family2(coredev, fw_buf, fw_buf_size)
> -			: loadfirmware_handler(coredev->context, fw_buf,
> -			fw_buf_size);
> +		rc = smscore_load_firmware_family2(coredev, fw_buf, fw_buf_size);
>  	}
>  
>  	kfree(fw_buf);
> @@ -1353,8 +1346,7 @@ int smscore_set_device_mode(struct smscore_device_t *coredev, int mode)
>  		}
>  
>  		if (!(coredev->modes_supported & (1 << mode))) {
> -			rc = smscore_load_firmware_from_file(coredev,
> -							     mode, NULL);
> +			rc = smscore_load_firmware_from_file(coredev, mode);
>  			if (rc >= 0)
>  				pr_debug("firmware download success\n");
>  		} else {
