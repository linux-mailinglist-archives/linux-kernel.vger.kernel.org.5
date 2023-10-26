Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FC07D862C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345477AbjJZPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJZPsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A9C198
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698335249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fk2PSPwJDmK9xnue8X0u8askj/ho1m46L6G3QWm1uws=;
        b=DlDuIC86QgYi0tKvV8viWte9iTILKCx5p3bdaFqio0GcB2wYvl2utJWbfXyOs6mB08ySfq
        V0qlMboWrJts07Bm8V0/rkO4mMVSK/Z9QSAdzgPop11tfci2NNJQRkoqXFNCUl826pWF00
        eBRUTyg9XZzRci/aqIGbgxaBJ4WXWNs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-0QmUYM2iP5--oPkt3hkRbA-1; Thu, 26 Oct 2023 11:47:27 -0400
X-MC-Unique: 0QmUYM2iP5--oPkt3hkRbA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b2cf504e3aso75294166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335245; x=1698940045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fk2PSPwJDmK9xnue8X0u8askj/ho1m46L6G3QWm1uws=;
        b=P7T/w7vf0+Gr4PRWqy+DCme72Z0i2EbRGu5owkVRqfxZSMkFaJkLIgs64MA6RrS1zQ
         e2o6yMrqlu6fxaLQZSvoAlMATw87LipybnubFFVIw2WtRe+XU4er7lcW+6w03pH5QtHR
         sINOqNnhYftm2DKDuAYXeYvC35ryJMk2+n98zvi6lqJaNpDYWyNWGrIQA/mekFRI5SdY
         dodFP69OjHhkJNt4+tDZXIMSQdx3O+LasgLGGd0QfpPH0AscgTicfqC0Cc1LaJhS1rIH
         cIoFvPpYWvjJK7mLDs6hq56jvTeC2Ff8qrAmCXZUZlsGdyPW+clw98fR7hdLpL8lnorx
         ED0g==
X-Gm-Message-State: AOJu0Yw2h46sPfgAJ9L4HGeTdHrFk6v+HX6eb68ceRCJtQv1oNau/L7D
        MVtOTB8KRmFrFYTUl+EkxT34/pV7pWpJ6Uw9ROkgXwfh3eBKUI5PftUrqd0YD3trCFZi/EeF8sO
        oC+Z3QC76ILrce9LjJeExqH6b
X-Received: by 2002:a17:907:804:b0:9ba:65e:750e with SMTP id wv4-20020a170907080400b009ba065e750emr69504ejb.32.1698335245335;
        Thu, 26 Oct 2023 08:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIzu0aS0oc/2eHVO/DT6wawL1gzMdNRmV1kFde8qwDfqO5GBCHprOwhqQcajFXJJ0yJKHm2g==
X-Received: by 2002:a17:907:804:b0:9ba:65e:750e with SMTP id wv4-20020a170907080400b009ba065e750emr69495ejb.32.1698335245019;
        Thu, 26 Oct 2023 08:47:25 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:37eb:8e1f:4b3b:22c7:7722])
        by smtp.gmail.com with ESMTPSA id dn22-20020a05640222f600b005401a4184ddsm8499249edb.27.2023.10.26.08.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:47:24 -0700 (PDT)
Date:   Thu, 26 Oct 2023 11:47:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, akpm@linux-foundation.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        shakeelb@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2] Fixing directly deferencing a __rcu pointer warning
Message-ID: <20231026114632-mutt-send-email-mst@kernel.org>
References: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
 <20231026121621.358388-1-singhabhinav9051571833@gmail.com>
 <20231026091222-mutt-send-email-mst@kernel.org>
 <CAGudoHFXH_FDgKRaJvVgQ3W8wD2TC=8yhiNm1NECApnQ-CNAZQ@mail.gmail.com>
 <20231026110925-mutt-send-email-mst@kernel.org>
 <dc028fd0-b188-435e-9dc3-f5de53dd9686@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc028fd0-b188-435e-9dc3-f5de53dd9686@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 09:07:46PM +0530, Abhinav Singh wrote:
> On 10/26/23 20:47, Michael S. Tsirkin wrote:
> > On Thu, Oct 26, 2023 at 04:06:24PM +0200, Mateusz Guzik wrote:
> > > On 10/26/23, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > On Thu, Oct 26, 2023 at 05:46:21PM +0530, Abhinav Singh wrote:
> > > > > This patch fixes the warning about directly dereferencing a pointer
> > > > > tagged with __rcu annotation.
> > > > > 
> > > > > Dereferencing the pointers tagged with __rcu directly should
> > > > > always be avoided according to the docs. There is a rcu helper
> > > > > functions rcu_dereference(...) to use when dereferencing a __rcu
> > > > > pointer. This functions returns the non __rcu tagged pointer which
> > > > > can be dereferenced just like a normal pointers.
> > > > > 
> > > > > Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> > > > 
> > > > Well yes but these need to be called under rcu_read_lock.
> > > > Who does it here?
> > > > If no one then maybe you found an actual bug and we need to
> > > > fix it not paper over it.
> > > > 
> > > 
> > > There is no bug here.
> > > 
> > > p is the newly created thread, ->real_cred was initialized just prior
> > > to this code and there is nobody to whack the creds from under it.
> > > 
> > > Second bit in the patch changes one real_parent deref, but leaves 2
> > > others just above it. Once more no bug since the entire thing happens
> > > under tasklist_lock, but the patch should either sort all these cases
> > > or none.
> Sparse reported 3 similar dereferencing warning this patch contains 2 fixes
> for 2, but yeah I should fixed all 3 of them.
> > > 
> > > I think it would help if the submitter had shown warnings they see.
> The warning message :- warning: dereference of noderef expression
> > 
> > Yes, and this must be tested under lockdep, which I think would
> > spit out warnings for this patch.
> Not sure, but I tested this with sparse (make C=2) and after the above
> changes I dont get the warning.

sparse is a static analysis tool. You should also actually
test your patch.

> > 
> > What should be used here I'm not sure. IIUC rcu_dereference_protected(p, 1)
> > is discouraged now?
> > 
> Not sure but I read that, rcu_dereference should be prefered when reading
> and rcu_dereference_protected should when writing.

