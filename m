Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385667FDA4A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjK2OsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjK2OsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:48:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCE1B0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701269293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MFzqrh0xCRuB2+k7XQGRqfBWGZI6cFLK12C66Jum2dE=;
        b=LQMspEEeu8VQdNFZ6idyJrhJVJFBxicqdjsOeCgo3eoYcaacdjUGdn/u1kG00VA+tMrBPh
        bEP0gficSI4i+q0Wu61Y3xgbu2K0WV7C7MPaFgpH+0bIZLvAchQWOweu1UbfdduIhYxa3s
        H1huo3KVKoEoiRiF/G30lB/Xqt1bhug=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-WQf7odOhO8aqWr4v4q8DYw-1; Wed, 29 Nov 2023 09:48:09 -0500
X-MC-Unique: WQf7odOhO8aqWr4v4q8DYw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67a4da4e3c3so35617256d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269289; x=1701874089;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFzqrh0xCRuB2+k7XQGRqfBWGZI6cFLK12C66Jum2dE=;
        b=elyIKSssUCO9cvSJ0fb81ktvcuU0yfatzLX8Hwpxf2G4tfCtI0TVY1lQQVcA/amuzw
         RdVvZqwtFzHg3doDdiVegtjYtrlTL+ZRbuR/UzeE6lE3zFjsZ4mMrOPjd2dLP3F+u/6r
         wTsnMUyBOf/CMybrTDbQCNy8NTsMPsPKjjPvBdoHy/eP+XJKa0cZgTQJbhjWV2qxTtDH
         ebDOJSPQLJCxKqDHubZf3RcJsAGN2QdegYTmnGohOG2aJfU8t1I881lws+pEf3poPGZ7
         4nPgVwVEDgJMDlLEwOMeLHsub6JTcPZvg/fmU8S41j4yygyUzFHTnFZzegrS6Idmji47
         e+JA==
X-Gm-Message-State: AOJu0YxOI7dqzQOimxQeyJRAB9RZJkXbBOKu7H8+qxSAbIXjDHTimqxy
        OZ4vGUI2OkVwN1AyLTzbiK81kERRr0arCZgFPNRpp0/OTBINu+qd2NNyykZlgrqnEBHOM5BPrMa
        vhz1h/PX1VFkNSc1/MM+9mEt4
X-Received: by 2002:ad4:4690:0:b0:66d:3716:4e14 with SMTP id pl16-20020ad44690000000b0066d37164e14mr13906379qvb.4.1701269289444;
        Wed, 29 Nov 2023 06:48:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR1J+F2tJR6UUsOb1ujw2zvaJBctB34SjfXwongFIrxqaUpUhB2SgOTZ7ODXSst5RgCPwkog==
X-Received: by 2002:ad4:4690:0:b0:66d:3716:4e14 with SMTP id pl16-20020ad44690000000b0066d37164e14mr13906356qvb.4.1701269289190;
        Wed, 29 Nov 2023 06:48:09 -0800 (PST)
Received: from [192.168.1.9] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id ea14-20020ad458ae000000b0067a33b921cdsm4059978qvb.42.2023.11.29.06.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 06:48:08 -0800 (PST)
Message-ID: <1f66c647-e51b-4640-cbff-67b17e2077ad@redhat.com>
Date:   Wed, 29 Nov 2023 09:48:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        attreyee-muk <tintinm2017@gmail.com>, jpoimboe@kernel.org,
        jikos@kernel.org, pmladek@suse.com, corbet@lwn.net,
        live-patching@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
References: <20231127155758.33070-1-tintinm2017@gmail.com>
 <202dbdf5-1adf-4ffa-a50d-0424967286ba@infradead.org>
 <ZWX1ZB5p5Vhz7WD2@casper.infradead.org>
 <0e7941d8-d9b2-4253-9ad5-0f7806e45e2e@infradead.org>
 <alpine.LSU.2.21.2311291105430.12159@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH] Took care of some grammatical mistakes
In-Reply-To: <alpine.LSU.2.21.2311291105430.12159@pobox.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 05:08, Miroslav Benes wrote:
> 
> I am not a native speaker, but "step on each other's toe" sounds the best 
> to me. Or perhaps even "they need to be aware of each other and not step 
> on their toes" since it is then kind of implied? English is difficult :).
> 

Native speaker here, so don't ask me what's grammatically accurate :D  I
would definitely say "step on" vs. "step over".  I would also write
"each other's toes", but not flinch if I read "each others' toes" or
even "each others toes".

After thinking about it for more that 30s, I might consider rewording
the sentence to avoid the idiom altogether, something like:  "Therefore
they need to coordinate to avoid interfering with each other."

-- 
Joe

