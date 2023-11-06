Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C716C7E2CCC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjKFT1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjKFT1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1D2F3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699298815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/C/WjxiCVsJz9f1oEP2Y4XakhqVX5j64dRCa7+qXYyE=;
        b=KFKfSKLsZvRM1jP+0Yx8/LcpT9Rc3guAu7MrF1yGo3FYKDkt41OcPYo2KZHDePk8dEJ/lH
        v267MAB6TyyVLa77nGYWiWBTuCCheeqpnXJxzPAP86QYUdJ2m30TYxS5MolRk5bivJIVIg
        VorHLkLHgJ6PlqFhodyzehZpVZtrqKQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-nw_5mYaNMaK_lDHyw0Pm6A-1; Mon, 06 Nov 2023 14:26:49 -0500
X-MC-Unique: nw_5mYaNMaK_lDHyw0Pm6A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77892f2ee51so537228085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699298809; x=1699903609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C/WjxiCVsJz9f1oEP2Y4XakhqVX5j64dRCa7+qXYyE=;
        b=ZCS95C/8H/6ZhNFh1f5cyah8NKJZGLi0P6jwMiR/sD+NW4hY1PfMHCB7IDGcCDpNVH
         j3U526seZ3VwK8O+3VEwh2wfTYcOxH8yKTTX9Gm3p4jHy2ZH6uMmUe4GPQp2J7qhl1HF
         C6jgqncApKiYDC5QeEpjCfHyFrUoShzlr3tiVd1AzYCoDJxKM9Zjd1U5LuJMJ9SrzJkI
         EWDDWWv891uZQ+6rdXsYHPh0Yf1bsn9oAxvAUQ8B7EgY+QBaEp34GM3U+TDAZ0aiIllq
         5iuww8X7AJCN6m5mBUZOGqhueRGdZwCB7y1Fk28Vxig/yx5T7gF6oVBZGnhDwxfLVC5l
         2BnA==
X-Gm-Message-State: AOJu0Yx+GTFGS8I3sfvh0rhEUjiJI0p7pm4pm5hl/dw1UX3Tn1WikQ/O
        WtJ1J5Erw4ZJ8AQxYM2RaxtcDZKmPmIR6zu/lqNBVgtG5d9UHHCzBZzPrjCSmActXsq2XY9K7xZ
        cdhiKqfEAN4FvfMYnmPvL3OkE
X-Received: by 2002:a05:620a:444b:b0:778:9542:a765 with SMTP id w11-20020a05620a444b00b007789542a765mr40268956qkp.64.1699298809004;
        Mon, 06 Nov 2023 11:26:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4J4SaJitD2GuvTLmTEH/lixSVaiP4mCjrPIimN2+kmtJXKyqkH9XwjIiR80Gp98vcOrUInw==
X-Received: by 2002:a05:620a:444b:b0:778:9542:a765 with SMTP id w11-20020a05620a444b00b007789542a765mr40268946qkp.64.1699298808800;
        Mon, 06 Nov 2023 11:26:48 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x8-20020ae9f808000000b007756e75b91bsm3554551qkh.78.2023.11.06.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:26:48 -0800 (PST)
Date:   Mon, 6 Nov 2023 12:26:46 -0700
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
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Julien Gomes <julien@arista.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] tpm: Store TPM buffer length
Message-ID: <lifu6orgfo57usei3szyfrmr6ofl37477gji5xh5bwkhftswxg@cjwwa5okjshi>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-3-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024011531.442587-3-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

