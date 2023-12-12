Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A76B80F417
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjLLRKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLRJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC810B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702401004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTsmW17WUzLud/2jzNOtfYA8w5ZvrrOIfNd+fsou+94=;
        b=bklj3+33lLMWn+LeyVfLT3jLAwp6n2JEh/h7Fb+UypjeXvrk89D3D8L33LGVPiwjQnctyW
        tGg7JdVW1CK9paWZpffjOSKpLc35bmOrXcPvURe4Ekc7I28QnpxFrH1eyOeJGcu+8tp2rf
        O4vdyGOwxbDAo2SZ3nRQEOjUP9IpSvE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-962USCOoOhGd9JKuiWFyvw-1; Tue, 12 Dec 2023 12:10:02 -0500
X-MC-Unique: 962USCOoOhGd9JKuiWFyvw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d05708dde4so62727065ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401001; x=1703005801;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTsmW17WUzLud/2jzNOtfYA8w5ZvrrOIfNd+fsou+94=;
        b=mujophZCkusxKU9Q5ujbb803zggU35lNqVMaZijUrqIzJCL0+uFZEER5mDt4oCYEeX
         QssjfNPFc/xY+//XZ3OkXONBYVQQ5XpNKzCL4S4kK355eiVyTlQrakbnSdO/WlPLpkPt
         pU+NYxPE5Q0MMwRCJuyGDc6KWohhPkDDnczLo4MvY2H8tmvliu307nnd6NprpXdfvhmP
         GgAz++jmyS/FbYasxTw4fbPYO0gelzP8+BPT68ggpMJVkn29mypH0NPc/0TpeBlGG3pW
         ggnBvCWVij6Ed39l3Uxbr2M2buC+sGs95xj0HEBW+kXktz6HJeikJ4Z5Df/kW1AYasID
         vqFg==
X-Gm-Message-State: AOJu0YzBbSuT03O3xucwPMp9pV4sbqD+74pBGdxzpzqDEvP5XLqx2Oie
        AZUVVJa/ugz1GVy8vGR/L2KTsmtbykqUNWkmyo+a/g84+JvFNXgNy8+jWbRLrpiu1PAgO8OJqDf
        vVr1SCU4ZraGzueRZcyFnq26FR9yBc3HS
X-Received: by 2002:a17:902:eb88:b0:1d0:265:6a2c with SMTP id q8-20020a170902eb8800b001d002656a2cmr7793183plg.11.1702401001171;
        Tue, 12 Dec 2023 09:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUOPW83vh6/yFOfLem9iMzay8K3e+XQC3CNiFpYGPaAVfwiBjhwWox62jHYqHe8pPGMa2chA==
X-Received: by 2002:a17:902:eb88:b0:1d0:265:6a2c with SMTP id q8-20020a170902eb8800b001d002656a2cmr7793162plg.11.1702401000838;
        Tue, 12 Dec 2023 09:10:00 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:3102:945e:6f76:fb73:6512])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001d0969c5b68sm8851113plk.139.2023.12.12.09.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:10:00 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Leonardo Bras <leobras@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/1] scripts: Introduce a default git.orderFile
Date:   Tue, 12 Dec 2023 14:09:43 -0300
Message-ID: <ZXiT1zyADQVXOEqw@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZXhbUmxzH6nWAzaw@infradead.org>
References: <20231208181802.88528-3-leobras@redhat.com> <ZXgMa57Ere6FJCJB@infradead.org> <CAK7LNAQiJW0eFYQZN0wuURhrdc-8y7=TcEazpxhLf=+mRbKHHQ@mail.gmail.com> <ZXhbUmxzH6nWAzaw@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:08:34AM -0800, Christoph Hellwig wrote:
> On Tue, Dec 12, 2023 at 05:09:21PM +0900, Masahiro Yamada wrote:
> > Unlike .gitignore, this feature is opt-in rather than enforced.
> > 
> > To use this, you need to run
> > 
> > 'git config diff.orderFile scripts/git.orderFile'
> > 
> > or
> > 
> > 'git diff -C scripts/git.orderFile'
> 
> Oh, ok.  That greatly reduces my concern.

Yes, it's an opt-in, so no user should be directly impacted.

> 
> > 
> > Indeed, the file order is subjective, leaving
> > us a question "do we need it in upstream"?

The main idea is patch generation.
This file's order is supposed to be the best order for reading a raw patch 
and understanding the code changes. 

> > 
> > At least, it is harmless for people who have no interest.
> 
> .. but this is still a good question.  I'm not really sure there is
> much of a need for it, but as long as it doesn't harm everyone else
> I'm at least neutral on it.

diff.orderfile was introduced in git to help order the git diff, and thus 
the patch generation, in a way that it's easier to understand what the 
commit / patch intends on doing. 

Take this example introducing a feature foo, you should see:
- Documentation on foo, if introduced
- How is foo enabled in build system, if needed
- The types / stucts / fields introduced by foo, if any
- The interface for using foo, if any
- The actual foo implementation.

Of course the actual order is open to discussion, and I encourage everyone 
to suggest any other items or order.

Thanks!
Leo

