Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B921A7514E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjGMABa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGMAB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:01:27 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ABB1BF2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:01:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b5a3915f5so172881a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689206485; x=1691798485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0qLBx3uxcrHWU+4CKXWElnfWUqgK44NqsxabxSLOECE=;
        b=B1B/eZfn9bNWsWlbBOJfPEXF0cv3PHdoFj6/puu75yRYQ6hR/FMvn7hMAyf3uRG951
         ogAXhnjBYo7WIVtVE3X6PnlKeO6Ma10TIBaZvHmtkbkNGpd0q4Zfe8QxUrJezhpNtI0x
         wdpF9CrzuIOZo/vKt/JFUsdFEYzgHXTzjsaOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689206485; x=1691798485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qLBx3uxcrHWU+4CKXWElnfWUqgK44NqsxabxSLOECE=;
        b=FevpefbvUrR1XJ+nCKFjI8XAHkqzGLROE/ebNyPeRoCJ0PjHyTlS2ASxHM8XIigSKU
         j+MZNBIoMgUqpTL6LfDysL7I8SwN4UI5VOlyXZadsrYPZZGVS83PPrBN8ow+tKGTbvTF
         5PCDoJXYl4ZDVzBGzYiXxZtyFxqq1tyffNhVsnOIKEd4DrJXRDPpO6bYDpnvGpNEA2e0
         vILJoJgrtnFZJqUCVfIBY1lyEF4e+rCcuMIkTQHAceEYq6oS2x1X+MAfejIQ1yE/z6oa
         m6eW8bFCCc3JXYoGLV3yS84ZwDcZXqbqqzGk8NjPaYwkOcB/Ul3ov8BFInyolGqVPZwr
         zakA==
X-Gm-Message-State: ABy/qLbZtHEYxXCh3WHArLcig70qOfR0LpQVmzmU6Dl7h/MnF4ofaq1V
        /EOmTapxEU2SB7cq3GWeWsCBUA==
X-Google-Smtp-Source: APBJJlHRc+Ar5BpR3UE05A6vqdWxvJAvJzqLldCXNFVS9NCNFm2N1m+vrmR8WZ2BLRqBd0gJI6Nvbw==
X-Received: by 2002:a17:903:26c9:b0:1b8:6850:c3c4 with SMTP id jg9-20020a17090326c900b001b86850c3c4mr106520plb.22.1689206484013;
        Wed, 12 Jul 2023 17:01:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001b895a18472sm4519165plg.117.2023.07.12.17.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 17:01:23 -0700 (PDT)
Date:   Wed, 12 Jul 2023 17:01:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] smb: client: Fix -Wstringop-overflow issues
Message-ID: <202307121658.1C4E9C928D@keescook>
References: <ZK3h3+dHBGONHt+S@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK3h3+dHBGONHt+S@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:12:31PM -0600, Gustavo A. R. Silva wrote:
> pSMB->hdr.Protocol is an array of size 4 bytes, hence when the compiler
> analyzes this line of code
> 
> 	parm_data = ((char *) &pSMB->hdr.Protocol) + offset;
> 
> it legitimately complains about the fact that offset points outside the
> bounds of the array. Notice that the compiler gives priority to the object
> as an array, rather than merely the address of one more byte in a structure
> to wich offset should be added (which seems to be the actual intention of
> the original implementation).
> 
> Fix this by explicitly instructing the compiler to treat the code as a
> sequence of bytes in struct smb_com_transaction2_spi_req, and not as an
> array accessed through pointer notation.
> 
> Notice that ((char *)pSMB) + sizeof(pSMB->hdr.smb_buf_length) points to
> the same address as ((char *) &pSMB->hdr.Protocol), therefore this results
> in no differences in binary output.
> 
> Fixes the following -Wstringop-overflow warnings when built s390
> architecture with defconfig (GCC 13):
>   CC [M]  fs/smb/client/cifssmb.o
> In function 'cifs_init_ace',
>     inlined from 'posix_acl_to_cifs' at fs/smb/client/cifssmb.c:3046:3,
>     inlined from 'cifs_do_set_acl' at fs/smb/client/cifssmb.c:3191:15:
> fs/smb/client/cifssmb.c:2987:31: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>  2987 |         cifs_ace->cifs_e_perm = local_ace->e_perm;
>       |         ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> In file included from fs/smb/client/cifssmb.c:27:
> fs/smb/client/cifspdu.h: In function 'cifs_do_set_acl':
> fs/smb/client/cifspdu.h:384:14: note: at offset [7, 11] into destination object 'Protocol' of size 4
>   384 |         __u8 Protocol[4];
>       |              ^~~~~~~~
> In function 'cifs_init_ace',
>     inlined from 'posix_acl_to_cifs' at fs/smb/client/cifssmb.c:3046:3,
>     inlined from 'cifs_do_set_acl' at fs/smb/client/cifssmb.c:3191:15:
> fs/smb/client/cifssmb.c:2988:30: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>  2988 |         cifs_ace->cifs_e_tag =  local_ace->e_tag;
>       |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> fs/smb/client/cifspdu.h: In function 'cifs_do_set_acl':
> fs/smb/client/cifspdu.h:384:14: note: at offset [6, 10] into destination object 'Protocol' of size 4
>   384 |         __u8 Protocol[4];
>       |              ^~~~~~~~
> 
> This helps with the ongoing efforts to globally enable
> -Wstringop-overflow.
> 
> Link: https://github.com/KSPP/linux/issues/310
> Fixes: dc1af4c4b472 ("cifs: implement set acl method")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/smb/client/cifssmb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> index 19f7385abeec..9dee267f1893 100644
> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@ -3184,7 +3184,7 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
>  	param_offset = offsetof(struct smb_com_transaction2_spi_req,
>  				InformationLevel) - 4;
>  	offset = param_offset + params;
> -	parm_data = ((char *) &pSMB->hdr.Protocol) + offset;
> +	parm_data = ((char *)pSMB) + sizeof(pSMB->hdr.smb_buf_length) + offset;
>  	pSMB->ParameterOffset = cpu_to_le16(param_offset);
>  
>  	/* convert to on the wire format for POSIX ACL */

This looks correct, though looking at this code I think some serious
comments are needed to describe _why_ these offsets are calculated the
way the are. The only dynamic part of parm_data is name_len, and could
just as easily be calculated as:

	parm_data = pSMB->FileName + name_len;

which is MUCH more readable. But, yes, the above patch does result in
the same binary code.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
