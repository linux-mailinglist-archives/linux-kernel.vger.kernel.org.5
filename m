Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E027080E4F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjLLHla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLHl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:41:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35DFC2;
        Mon, 11 Dec 2023 23:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BR0GaKh1S4JeZ9xjnS0mdRlav8bDaJHAovNcXYJH2Vo=; b=NwcMeZFZ0khJl1V+L+Wl4YRXrd
        SxUF0Pjlux4EICl+LyraoIkrBjSjaIKVORnpUeoanTFTkehRAb+zVFSXUB8k3Ua5JjkGxA8iHLqhy
        OCDQer6cxLVIbNo0Q9E4hzOnd08VpZQOZjXRXseM6DcueKjp1VTULYURG3ZFw5beS8MgE7XryCng2
        ln8fm0nC01FYPjKzNFvgMDDaZNvUEu/lyG9ciDjbFaMHyB8kfkywdNLplSasCh649akcfoK4zSBN1
        EkG7+GNhpYWi/KG34VHJ+X0frnW0GstEtJb0URpxq3BlXajIA1jbFk4k9EGfcVNjadjf7kRXaxMT+
        75zDTO2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCxOP-00Awjy-0d;
        Tue, 12 Dec 2023 07:41:25 +0000
Date:   Mon, 11 Dec 2023 23:41:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Dodji Seketeli <dodji@redhat.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Jordan Crouse <jorcrous@amazon.com>
Subject: Re: [PATCH v7 3/3] check-module-params: Introduce
 check-module-params.sh
Message-ID: <ZXgOpRzNYGtiE35T@infradead.org>
References: <20231212020259.2451253-1-quic_johmoo@quicinc.com>
 <20231212020259.2451253-4-quic_johmoo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212020259.2451253-4-quic_johmoo@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 06:02:59PM -0800, John Moon wrote:
> One part of maintaining backwards compatibility with older
> userspace programs is avoiding changes to module parameters.

Really?  I don't think module parameters are a UAPI in the traditional
sense.  Now if you break a heavily used one you got to fix it, but
applying strict stability guarantees on module options which are not
availble to normal users or even normal programs doesn't make a whole
lot of sense.

