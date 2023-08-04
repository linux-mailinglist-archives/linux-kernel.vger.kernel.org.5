Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8A576F979
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 07:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjHDFPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 01:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjHDFN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:13:27 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF9E4EC4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 22:11:29 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-790c6d966e0so64445639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 22:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691125889; x=1691730689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9mXHvfvIJ86YmhvvCOBZgm/vP7NqAH1aP/FOLgaiHHM=;
        b=w0u26uP1zSf9/wGVBmdBh+lsfIcl5US1M1ShyfndXMrO7UGBqziwbcrQDCWG+sYz88
         gW5qL+yNBaYAHnphtPeS6vtre6uKPmddqpjhqyYoeCeaXGxCPO4zDQWaUTTDe0wPiXAT
         PT9FC5LROIPjcinOssm+gR+g3V/Zt3VS/QxM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691125889; x=1691730689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mXHvfvIJ86YmhvvCOBZgm/vP7NqAH1aP/FOLgaiHHM=;
        b=kC9wLehONwx87uiqLXfiZa4WzbXPBu5RPVhXHMj7kvBB1bgdxlhPnKKJTLNucoxw4b
         zEMU/0AEVSUjpAvWmPDB0SU/L/6RdSofzdmKg3sFu1SeA+Ejbo/FFo/ALy184G8Gz94i
         X48RW7nlWkryfEdKgMyrx7bP6qrYzazKlH8/ffAL81/ALSK3e99witrWDO+L4nbm1Owt
         UfVGjzvNXk88HlScHLsOf+/uVbCP6j+kwLYNg8zJIJwA3SKP7dLy3diQpfOW6bUg/gbD
         yHW08vPI9+ar9VsaPJAL74mj9N0qARYjeXM4sZhG9T4o0gStaigR6UZqGNrLRqI5rH4Y
         3XZw==
X-Gm-Message-State: AOJu0Yws2FemFL7Drjgj7q2ZdaXFqkST64/Ejju7hlvj4cIXQ92Xq6ab
        2FQ5Byk79jrzWcnZCfkZXA55dw==
X-Google-Smtp-Source: AGHT+IF3rVl5MnFnibYL2nSDUEkUozI392hnFu0eIKgFCwCfBZoGMPClTmzkhKJt8KlHfXF+LIVQxw==
X-Received: by 2002:a5e:a619:0:b0:790:d21a:a7ba with SMTP id q25-20020a5ea619000000b00790d21aa7bamr790640ioi.15.1691125889318;
        Thu, 03 Aug 2023 22:11:29 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d8405000000b0076ffebfc9fasm403681ion.47.2023.08.03.22.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 22:11:28 -0700 (PDT)
Date:   Fri, 4 Aug 2023 05:11:27 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/2] docs: memory-barriers: Add note on plain-accesses to
 address-dependency barriers
Message-ID: <20230804051127.GA3860381@google.com>
References: <20230803032408.2514989-1-joel@joelfernandes.org>
 <20230803032408.2514989-2-joel@joelfernandes.org>
 <626d1b48-de6a-4a0b-95d3-3ac438878757@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626d1b48-de6a-4a0b-95d3-3ac438878757@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:52:06AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 03, 2023 at 03:24:07AM +0000, Joel Fernandes (Google) wrote:
> > The compiler has the ability to cause misordering by destroying
> > address-dependency barriers if comparison operations are used. Add a
> > note about this to memory-barriers.txt and point to rcu-dereference.rst
> > for more information.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  Documentation/memory-barriers.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index 06e14efd8662..acc8ec5ce563 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -435,6 +435,11 @@ Memory barriers come in four basic varieties:
> >       variables such as READ_ONCE() and rcu_dereference() provide implicit
> >       address-dependency barriers.
> >  
> > +     [!] Note that address dependency barriers can be destroyed by comparison
> > +     of a pointer obtained by a marked accessor such as READ_ONCE() or
> > +     rcu_dereference() with some value.  For an example of this, see
> > +     rcu_dereference.rst (part where the comparison of pointers is discussed).
> 
> Hmmm...
> 
> Given that this is in a section marked "historical" (for the old
> smp_read_barrier_depends() API), why not instead add a pointer to
> Documentation/RCU/rcu_dereference.rst to the beginning of the section,
> noted as the updated material?

Sounds good. There's also another section in the same file on Address
dependency barriers (also marked historical). So something like the
following?

---8<-----------------------

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index acc8ec5ce563..ba50220716ca 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -396,6 +396,10 @@ Memory barriers come in four basic varieties:
 
 
  (2) Address-dependency barriers (historical).
+     [!] This section is marked as HISTORICAL: For more up-to-date
+     information, including how compiler transformations related to pointer
+     comparisons can sometimes cause problems, see
+     Documentation/RCU/rcu_dereference.rst.
 
      An address-dependency barrier is a weaker form of read barrier.  In the
      case where two loads are performed such that the second depends on the
@@ -561,6 +565,9 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 
 ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
 ----------------------------------------
+[!] This section is marked as HISTORICAL: For more up-to-date information,
+including how compiler transformations related to pointer comparisons can
+sometimes cause problems, see Documentation/RCU/rcu_dereference.rst.
 
 As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
 DEC Alpha, which means that about the only people who need to pay attention
