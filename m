Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0698128B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjLNHFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjLNHFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:05:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018EEBD;
        Wed, 13 Dec 2023 23:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=4slyeD5EvzOfztpiALJMdYd8jcSY1vW3E0D2GiEfKMQ=; b=lbFijQYsAtHhxD/lSG/mlBDNzg
        a+sFZ/q8pdVnb3J6aQBlmkotRNosiMegNu1YipScZtMdeGzfOVX4W13c5ilZWxoQ74xHOql66tTDw
        qDtcK2/KoCha3MAQrcz+iXXDuiTvkT9NRRKoDMZI4IRXaz4xoHkOCXT4X19x2ehEtytmedDe9NiJU
        PEF4E6CrDE/aU8y7fG6AYqruQExln+12ZslMgXGeIa12q2ig1aWcjA4VcD4/leQBf+mqnyLn/Y9JA
        YglViRgZEc3aAIfC0JP6la81CZACMd4P768GBikCEEQc6cRNAh/S0omFquZ/N6uko21kuQJi89+I8
        7EWQWF/w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rDfmw-00H3gz-2b;
        Thu, 14 Dec 2023 07:05:42 +0000
Message-ID: <bd003104-f09a-4904-90ce-ade286a2d051@infradead.org>
Date:   Wed, 13 Dec 2023 23:05:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/kernel-doc: restore warning for Excess
 struct/union
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20231214070200.24405-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231214070200.24405-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(correcting Mauro's email address)


On 12/13/23 23:02, Randy Dunlap wrote:
> The warning for Excess struct or union member description was
> removed when the $nested parameter of check_sections() was removed.
> This causes some kernel-doc notation warnings to be missed.
> 
> Recently the kernel test robot somehow reported an Excess member. The
> code in kernel-doc has not issued that warning since kernel v4.16, so I
> don't know how the robot did it. (See the Link for the report.)
> 
>   drivers/net/wireless/intel/iwlwifi/fw/dbg.c:86: warning: Excess struct/union/enum/typedef member 'trans_len' description in 'iwl_fw_dump_ptrs'
> 
> I patched that warning away even though I could not reproduce the
> warning from kernel-doc. The warning should be issued for extraneous
> struct member or union member description, so restore it.
> 
> Fixes: 1081de2d2f91 ("scripts: kernel-doc: get rid of $nested parameter")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/all/202312060810.QT9zourt-lkp@intel.com/
> Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  scripts/kernel-doc |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff -- a/scripts/kernel-doc b/scripts/kernel-doc
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1659,6 +1659,13 @@ sub check_sections($$$$$) {
>  					"'$sects[$sx]' " .
>  					"description in '$decl_name'\n");
>  			}
> +			elsif (($decl_type eq "struct") or
> +		       	       ($decl_type eq "union")) {
> +				emit_warning("${file}:$.",
> +					"Excess $decl_type member " .
> +					"'$sects[$sx]' " .
> +					"description in '$decl_name'\n");
> +			}
>  		}
>  	}
>  }

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html
