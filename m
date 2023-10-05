Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24F27BA219
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjJEPN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjJEPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE8129B34
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696516933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EcYpFc5fQ2y3uLxjaGAy7lsrM21+5zwRHwXefFI3p3Q=;
        b=UQ/8vbZuGoQ9t158NccRXBVxt79EErtuzCofWy6hSIISWc6s+8Vq1VXPaRE6OzELi2AAhM
        gR4EoYTrwTuEYhCDHA5jgTcB7T7nSxIBc+oTTpVJ9gtxbAvQh5WFuLi/bfp3K8JCfPLY66
        +h6jilfhuBiA6Gtlzy7TWrS76idN5hM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-4j2txenZOwGmSOD83yHiGw-1; Thu, 05 Oct 2023 06:39:09 -0400
X-MC-Unique: 4j2txenZOwGmSOD83yHiGw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5386aefc01eso111889a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696502348; x=1697107148;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcYpFc5fQ2y3uLxjaGAy7lsrM21+5zwRHwXefFI3p3Q=;
        b=Le2RE0IXAPVdASBT4QzBQFTXSD7CrTu+u+aWOhU0nD/3cBsK3RnsXX8Mn1JjTOiMxY
         p03k4vl1mro6jYqzhk5rJoJOmRwBFwi/0+9hrxjpote8+hFNJj8IsSZAgA5wgcqOxDt9
         AVf/oT5+GKLN2pMz9g0/O3OtBKMSwHj3uguqYWYRN3ovnkDDF9OrTaRihFPjxajY1/uG
         7zwNWAQE9ODzo45/ApWROPPDSx78u1AW0o6onirRNwrJ/vG5eW6CgfrfksLfH4PmQEfq
         Zbw5WcnlqAJZMyRupFCwbXRGHTsTyGev/iLPbTiQ1yAb3u6GbdPqk9vGeTsmG29k9uDb
         2T9w==
X-Gm-Message-State: AOJu0YzmZpGXYPGXFxTKdCEvonl8toCD/bZ6P07jJKNQ4PIZglx9Ah5e
        /8+ugOXwG2TMsA+E7yPrQi9bigNJzq3k1RvMB71N6l6GGJ6e7iCYIdSSyFBseb1FYki6pZiEGce
        zZAejhWBfMBC1sznNmR6KfVbI
X-Received: by 2002:a05:6402:5191:b0:51e:5dd8:fc59 with SMTP id q17-20020a056402519100b0051e5dd8fc59mr4227653edd.1.1696502348324;
        Thu, 05 Oct 2023 03:39:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXoi9NQo5thKA2z7QAg6O6iVK7LWh7JCWMxNO5nWP25rBMF90nlazkgDGpx4ETuytneK118Q==
X-Received: by 2002:a05:6402:5191:b0:51e:5dd8:fc59 with SMTP id q17-20020a056402519100b0051e5dd8fc59mr4227628edd.1.1696502347918;
        Thu, 05 Oct 2023 03:39:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-9.dyn.eolo.it. [146.241.225.9])
        by smtp.gmail.com with ESMTPSA id y20-20020aa7d514000000b00537708be5c6sm869929edq.73.2023.10.05.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:39:07 -0700 (PDT)
Message-ID: <2554ed057e08e66dd110c3e09a27378b9a06bdd6.camel@redhat.com>
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
From:   Paolo Abeni <pabeni@redhat.com>
To:     Hannes Reinecke <hare@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Leech <cleech@redhat.com>,
        Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Oct 2023 12:39:05 +0200
In-Reply-To: <0e0040be-0375-4461-914d-1ea9d04ee62c@suse.de>
References: <20230929170023.1020032-1-cleech@redhat.com>
         <20230929170023.1020032-4-cleech@redhat.com>
         <2023093055-gotten-astronomy-a98b@gregkh>
         <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox>
         <2023093002-unlighted-ragged-c6e1@gregkh>
         <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de>
         <2023100114-flatware-mourner-3fed@gregkh>
         <7pq4ptas5wpcxd3v4p7iwvgoj7vrpta6aqfppqmuoccpk4mg5t@fwxm3apjkez3>
         <20231002060424.GA781@lst.de>
         <tf2zu6gqaii2bjipbo2mn2hz64px2624rfcmyg36rkq4bskxiw@zgjzznig6e22>
         <2023100233-salsa-joyous-6d8c@gregkh>
         <0e0040be-0375-4461-914d-1ea9d04ee62c@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-02 at 10:59 +0200, Hannes Reinecke wrote:
> On 10/2/23 10:46, Greg Kroah-Hartman wrote:
> > On Mon, Oct 02, 2023 at 12:50:21AM -0700, Jerry Snitselaar wrote:
> > > On Mon, Oct 02, 2023 at 08:04:24AM +0200, Christoph Hellwig wrote:
> > > > On Sun, Oct 01, 2023 at 07:22:36AM -0700, Jerry Snitselaar wrote:
> > > > > Changes last year to the dma-mapping api to no longer allow __GFP=
_COMP,
> > > > > in particular these two (from the e529d3507a93 dma-mapping pull f=
or
> > > > > 6.2):
> > > >=20
> > > > That's complete BS.  The driver was broken since day 1 and always
> > > > ignored the DMA API requirement to never try to grab the page from =
the
> > > > dma coherent allocation because you generally speaking can't.  It j=
ust
> > > > happened to accidentally work the trivial dma coherent allocator th=
at
> > > > is used on x86.
> > > >=20
> > >=20
> > > re-sending since gmail decided to not send plain text:
> > >=20
> > > Yes, I agree that it has been broken and misusing the API. Greg's
> > > question was what changed though, and it was the clean up of
> > > __GFP_COMP in dma-mapping that brought the problem in the driver to
> > > light.
> > >=20
> > > I already said the other day that cnic has been doing this for 14
> > > years. I'm not blaming you or your __GFP_COMP cleanup commits, they
> > > just uncovered that cnic was doing something wrong. My apologies if
> > > you took it that way.
> >=20
> > As these devices aren't being made anymore, and this api is really not =
a
> > good idea in the first place, why don't we just leave it broken and see
> > if anyone notices?
> >=20
> Guess what triggered this mail thread.
> Some customers did notice.
>=20
> Problem is that these devices were built as the network interface in=20
> some bladecenter machines, so you can't just replace them with a=20
> different Ethernet card.

This route looks a no-go.

Out of sheer ignorance, would the iommu hack hinted in the cover letter
require similar controversial changes?

Cheers,

Paolo

