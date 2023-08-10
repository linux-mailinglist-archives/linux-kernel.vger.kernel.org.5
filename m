Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E22777C41
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbjHJPfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbjHJPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:34:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BF626B9;
        Thu, 10 Aug 2023 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=uiaKz3kmyqwtAsQ+m4lUcc+XfUWQizMTAyHXudFCUts=; b=0sTFD2dobCfvkVdaYNYksGeWwS
        HC6JZ9QkLai4kzPXbkiRtm16EzeWVs+tVyLDP4kBh8SlecZusjhk+OpisNGLRQaBiFDCMYnSm28Se
        DVDwp3WQaX0Cu5locixK+8lkY67YkcRWyHyKtUqCGTAOziOJL6kTCeajFx+5VTR7gglenD7BOISSt
        3NVl+rouExtOxMABAc2hcs2sJz/ot1mexFFNYf7fGQFz4IsGbtVZJNfvfuiRndwB7ctCsRxm5mlm5
        DM3OuabbfMN6WB1QTYIiDH8w+2TZYaprnPDcvv0syy+HjWND+QJOixAbUo9VWVj4M6CKjhUSZOHzi
        w6uEfmbA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qU7gH-0083T7-2V;
        Thu, 10 Aug 2023 15:34:33 +0000
Message-ID: <0d0ed95c-1ad4-25b1-fa6a-c432b7b0c9f4@infradead.org>
Date:   Thu, 10 Aug 2023 08:34:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] docs: staging: add netlink attrs best practices
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>, Lin Ma <linma@zju.edu.cn>
Cc:     corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, void@manifault.com,
        jani.nikula@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230809032552.765663-1-linma@zju.edu.cn>
 <ZNTw+ApPS9U4VhZI@vergenet.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZNTw+ApPS9U4VhZI@vergenet.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/23 07:15, Simon Horman wrote:
> On Wed, Aug 09, 2023 at 11:25:52AM +0800, Lin Ma wrote:
>> Provide some suggestions that who deal with Netlink code could follow
>> (of course using the word "best-practices" may sound somewhat
>> exaggerate).
>>
>> According to my recent practices, the parsing of the Netlink attributes
>> lacks documents for kernel developers. Since recently the relevant docs
>> for Netlink user space get replenished, I guess is a good chance for
>> kernel space part to catch with.
>>
>> First time to write a document and any reviews are appreciated.
>>
>> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> 
> Thanks for writing this up, from my perspective this is very useful.
> 
> Some trivial feedback follows.
> 
>> ---
>> v1 -> v2: fix some typos in FOO example,
>>           add extra section "About General Netlink Case" to avoid any
>>           confusion for new code users.
>>
>>  Documentation/staging/index.rst               |   1 +
>>  .../staging/netlink-attrs-best-practices.rst  | 544 ++++++++++++++++++
>>  MAINTAINERS                                   |   1 +
> 
> Perhaps this was discussed earlier.
> But I'm curious to know if there is a preference for putting
> this into staging rather than networking or elsewhere.

I don't know of any reason for it to be in staging. If there is one,
I would like to hear about it.

>>  3 files changed, 546 insertions(+)
>>  create mode 100644 Documentation/staging/netlink-attrs-best-practices.rst
>>

>> diff --git a/Documentation/staging/netlink-attrs-best-practices.rst b/Documentation/staging/netlink-attrs-best-practices.rst
>> new file mode 100644
>> index 000000000000..7dac562bee47
>> --- /dev/null
>> +++ b/Documentation/staging/netlink-attrs-best-practices.rst
>> @@ -0,0 +1,544 @@
>> +.. SPDX-License-Identifier: BSD-3-Clause
>> +
>> +=================================
>> +Netlink Attributes Best Practices
>> +=================================
>> +
>> +Introduction
>> +============
>> +
>> +This document serves as a guide to the best practices, or cautions, for parsing user-space-provided Netlink attributes in kernel space. The intended audience is those who want to leverage the powerful Netlink interface (mainly for classic or legacy Netlink and the general Netlink users basically don't worry about these, see penultimate section) in their code. Additionally, for those who are curious about the parsing of Netlink attributes but may feel apprehensive about delving into the code itself, this document can serve as an excellent starting point.
> 
> I think it is normal to linewrap rst documentation.
> At <80 columns would be best IMHO.

absolutely.

> 
>> +
>> +However, if you are concerned about how to prepare Netlink messages from a user space socket instead of writing kernel code, it is recommended to read the `Netlink Handbook <https://docs.kernel.org/userspace-api/netlink/intro.html>`_ first.
>> +
>> +Background
>> +==========
>> +
>> +Data Structures
>> +---------------
>> +
>> +So what is a Netlink attribute? In simple terms, **the Netlink attribute is the structural payload carried by the Netlink message in TLV (Type-Length-Value) format** (At least it is suggested to do so). One can straightly read the comment and the code in ``include/net/netlink.h`` (most of the below content is derived from there). The following graph demonstrates the structure for the majority of messages.
> 
> Suggestion:
> 
> * straightly -> directly; or, perhaps better
>   one can straightly -> one can
> 
>> +
>> +.. code-block::
>> +
>> +   +-----------------+------------+--------------------------
>> +   | Netlink Msg Hdr | Family Hdr |  Netlink Attributes  ...
>> +   +-----------------+------------+--------------------------
>> +                     ^            ^
>> +
>> +The ``^`` part will be padded to align to ``NLMSG_ALIGNTO`` (4 bytes for the Linux kernel).
>> +
>> +The term **majority** is used here because the structure is dependent on the specific Netlink family you are dealing with. For example, the general Netlink family (NETLINK_GENERIC) puts ``struct genlmsghdr`` in the Family Hdr location and is strictly followed by specified Netlink attributes TLV. Differently, the connector Netlink family (NETLINK_CONNECTOR) does not use Netlink attributes for transiting the payload, but straight places naked data structure after its family header ``struct cn_msg``. In general, when working with Netlink-powered code, most developers opt for Netlink attributes due to their convenience and ease of maintenance. This means is definitely okay to overlook the corner cases which may eventually be incorporated into Netlink attributes in the future.
> 
> Suggestions:
> 
> * "Differently, the connector"
>   -> As a counter example, the connector"

s/counter example/counterexample/

> 
> * "but straight places naked data structure after its family header"
>   -> "but, rather, places a naked data structure immediately after its
>       family header"
> 
> 
>> +
>> +The Netlink attribute in the Linux kernel conforms to the following structure.
>> +
>> +.. code-block:: c
>> +
>> +   // >------- nla header --------<
>> +   // +-------------+-------------+----------- - - - ----------+
>> +   // |  Attr Len   |  Attr Type  |          Attr Data         |
>> +   // +-------------+-------------+----------- - - - ----------+
>> +   // >-- 2 bytes --|-- 2 bytes --|------ Attr Len bytes ------<
>> +
>> +   struct nlattr {
>> +       __u16           nla_len;
>> +       __u16           nla_type;
>> +   };
>> +
>> +The 2 bytes attr len (\ ``nla_len``\ ) indicates the entire attribute length (includes the nla header) and the other 2 bytes attr type (\ ``nla_type``\ ) is used by the kernel code to identify the expected attribute. To process these attributes, the kernel code needs to locate the specific attribute and extract the payload from it, a process known as attribute parsing. This procedure can be tedious and error-prone when done manually, so the interface provides parsers to simplify the process.
>> +
>> +*It is worth mentioning that if you choose to use general Netlink without a nested data structure, you don't even need to call any parsers as the interface already does this and your task will be simplified to handling the parsed result.*
>> +
>> +Parsers
>> +-------
>> +
>> +There are several parsers available, each designed to handle a specific type of object being parsed. If you have a pointer to a Netlink message, specifically a (\ ``struct nlmsghdr *``\ ), it's likely that you'll want to call the ``nlmsg_parse`` function. The prototype for this function is as follows:
>> +
>> +.. code-block:: c
>> +
>> +   /**
>> +    * nlmsg_parse - parse attributes of a netlink message
>> +    * @nlh: netlink message header
>> +    * @hdrlen: length of family specific header
>> +    * @tb: destination array with maxtype+1 elements
>> +    * @maxtype: maximum attribute type to be expected
>> +    * @policy: validation policy
>> +    * @extack: extended ACK report struct
>> +    *
>> +    * See nla_parse()
>> +    */
>> +   static inline int nlmsg_parse(const struct nlmsghdr *nlh, int hdrlen,
>> +                     struct nlattr *tb[], int maxtype,
>> +                     const struct nla_policy *policy,
>> +                     struct netlink_ext_ack *extack);
>> +

Instead of duplicating kernel-doc function comments here, it is preferable to do
what Jakub has started to do lately:

.. kernel-doc:: include/linux/netlink.h
   :identifiers: nlmsg_parse

Same for the functions below.

>> +Else if you have a pointer to Netlink attribute (\ ``struct nlattr *``\ ) already, the ``nla_parse``\ , or  ``nla_parse_nested`` could be your choices.
> 
> Suggestions:
> 
>   * Else -> Otherwise,
>   * "could be your choices" -> "may  be used"
> 
>> +
>> +.. code-block:: c
>> +
>> +   /**
>> +    * nla_parse - Parse a stream of attributes into a tb buffer
>> +    * @tb: destination array with maxtype+1 elements
>> +    * @maxtype: maximum attribute type to be expected
>> +    * @head: head of attribute stream
>> +    * @len: length of attribute stream
>> +    * @policy: validation policy
>> +    * @extack: extended ACK pointer
>> +    *
>> +    * Parses a stream of attributes and stores a pointer to each attribute in
>> +    * the tb array accessible via the attribute type. Attributes with a type
>> +    * exceeding maxtype will be rejected, policy must be specified, attributes
>> +    * will be validated in the strictest way possible.
>> +    *
>> +    * Returns 0 on success or a negative error code.
>> +    */
>> +   static inline int nla_parse(struct nlattr **tb, int maxtype,
>> +                   const struct nlattr *head, int len,
>> +                   const struct nla_policy *policy,
>> +                   struct netlink_ext_ack *extack);
>> +   /**
>> +    * nla_parse_nested - parse nested attributes
>> +    * @tb: destination array with maxtype+1 elements
>> +    * @maxtype: maximum attribute type to be expected
>> +    * @nla: attribute containing the nested attributes
>> +    * @policy: validation policy
>> +    * @extack: extended ACK report struct
>> +    *
>> +    * See nla_parse()
>> +    */
>> +   static inline int nla_parse_nested(struct nlattr *tb[], int maxtype,
>> +                      const struct nlattr *nla,
>> +                      const struct nla_policy *policy,
>> +                      struct netlink_ext_ack *extack);
>> +
>> +Upon closer inspection, one will notice that the parameters for the various parsers bear a striking resemblance to one another. In fact, they share a commonality that goes beyond mere coincidence, as they all ultimately call upon the same internal parsing helper function, namely ``__nla_parse``.
>> +
>> +.. code-block:: c
>> +
>> +   int __nla_parse(struct nlattr **tb, int maxtype, const struct nlattr *head,
>> +           int len, const struct nla_policy *policy, unsigned int validate,
>> +           struct netlink_ext_ack *extack);
>> +
>> +The idea is straightforward since we know that adding an offset to either the Netlink message header or the nested attribute will yield the TLV format of the attributes. On this basis, we will learn how to utilize those parsers.

[snip]

-- 
~Randy
