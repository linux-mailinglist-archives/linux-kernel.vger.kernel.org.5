Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732E57D8751
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbjJZRLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZRLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FC8D45
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698340231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/CIQaN2hYmBCGrEr5wSwlpK+Nw1/R/cDnWMd/K0WyEc=;
        b=i8zEmSO3CjHespn4rdbXmniIq+B9pyMP8DPvzU5+eWvPe3nRoMQ0v1pZ+hGYSa+b+Xu9gV
        NJV43QxCTfgAuifONTJAS4/gGIwN3loG9CWLhWntqBNjy279CvKHeMHNpMZYD3amV3tYtC
        ooC2SEq0pwm4ytvpCgiSI7FxxcNeI+I=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-GXtu-14sNO2R3fmFkX2KGA-1; Thu, 26 Oct 2023 13:10:29 -0400
X-MC-Unique: GXtu-14sNO2R3fmFkX2KGA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6ce27d056ceso1429851a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340228; x=1698945028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CIQaN2hYmBCGrEr5wSwlpK+Nw1/R/cDnWMd/K0WyEc=;
        b=qLMWldIDus1HvK56HoOUsunk71OGnSXUarTSr63iAQcSOF0wKyiNCL0VdRoOWOjY4b
         t6G4rO87K4x9IEyAHZjMuWzCNtTEWOpbn6D+Y2FH2pLNIEbm6mLQP073LUNnYPmeVrRJ
         ifR4VYehp+V5ZjQqTozjSjZ9Zlq8I+g3V9POrzsiFxs1bq2Bom62oPAvPt9kTElw9CUr
         uhLGAzc8YYt3NQz/tp1Ht1KPqkzC6M8tMTGq+vIVZqeWiUfj8pgdyxxV56C8CY3t2mMx
         wdJ0c/3ZOFo2euqlwlnLT7e8M0shsYg6U/OccY0JCfHf5I4tvwejctMbgv2zhPQCJPux
         uaHQ==
X-Gm-Message-State: AOJu0Yz2+p99HYkPKCCF9DoTZhcm/gNCApKBgotBgRHK1MAiMgz/du9W
        dUuySkkOjFbOUObpvBbtAq4AgFCP92dMc0z32tEzF07gqxnemnz/t5ZbLRU8iPlhnGc0yBHHdvo
        9zE75A5gSrww7WdkitawostpG
X-Received: by 2002:a05:6870:700e:b0:1e9:9469:a858 with SMTP id u14-20020a056870700e00b001e99469a858mr177898oae.39.1698340228767;
        Thu, 26 Oct 2023 10:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMcG7bFJI3uZvagRkgLSPwdpNdpoULYCl6UniOWGqMYyzyTbNJBhELZeGRoTmo2AKqS168Kw==
X-Received: by 2002:a05:6870:700e:b0:1e9:9469:a858 with SMTP id u14-20020a056870700e00b001e99469a858mr177884oae.39.1698340228525;
        Thu, 26 Oct 2023 10:10:28 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b23-20020ac86bd7000000b0041969bc2e4csm5160636qtt.32.2023.10.26.10.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:10:28 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:10:26 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Julien Gomes <julien@arista.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] tpm: Move buffer handling from static inlines to
 real functions
Message-ID: <g6grxamrilogiy4vjrvwwn6iz2xm26oeq2y7redbskvcreil6w@seavf5djd4ph>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-2-jarkko@kernel.org>
 <qktrbbbqrz3z4jh4h7pz42leikmyg2mdevzl2brapn32kst55e@s5thpstdtlxp>
 <CWHPA3T3YIJT.148L3L98EXBXD@suppilovahvero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CWHPA3T3YIJT.148L3L98EXBXD@suppilovahvero>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 08:35:55PM +0300, Jarkko Sakkinen wrote:
> On Wed Oct 25, 2023 at 12:03 PM EEST, Jerry Snitselaar wrote:
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> On Wed, 2023-10-25 at 02:03 -0700, Jerry Snitselaar wrote:
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> >
> 
> Thanks I'll add it to the next round.
> 
> For the tpm_buf_read(), I was thinking along the lines of:
> 
> /**
>  * tpm_buf_read() - Read from a TPM buffer
>  * @buf:	&tpm_buf instance
>  * @pos:	position within the buffer
>  * @count:	the number of bytes to read
>  * @output:	the output buffer
>  *
>  * Read bytes from a TPM buffer, and update the position. Returns false when the
>  * amount of bytes requested would overflow the buffer, which is expected to
>  * only happen in the case of hardware failure.
>  */
> static bool tpm_buf_read(const struct tpm_buf *buf, off_t *pos, size_t count, void *output)
> {
> 	off_t next = *pos + count;
> 
> 	if (next >= buf->length) {
> 		pr_warn("%s: %lu >= %lu\n", __func__, next, *offset);
> 		return false;
> 	}
> 
> 	memcpy(output, &buf->data[*pos], count);
> 	*offset = next;
> 	return true;
> }
> 
> BR, Jarkko
> 

Then the callers will check, and return -EIO?

