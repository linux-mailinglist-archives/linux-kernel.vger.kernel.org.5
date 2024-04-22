Return-Path: <linux-kernel+bounces-152716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181DD8AC354
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BFFB1C20D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E520710A2A;
	Mon, 22 Apr 2024 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPQ+n+vY"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D28831;
	Mon, 22 Apr 2024 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713758682; cv=none; b=Npv49bcx+E7Yby5hE22MxZFmFZu2MsMmkPQPM7t1bXk0Om1dY6zHvK2d7B0Ns9zLitBTPTsGos2IX7LHp59r1Tc5ZnsFU454WKY4wR0CZWV+TKcgeEmOrVk9VD4PewMV10w15wK8A7nvOlXxTCW666YMCMiVox3Kjqp+PDplN4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713758682; c=relaxed/simple;
	bh=o9H203Nw0CSU+bl/koMHamR78hDvCazO1kH0pDFgFrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdCajHCi8fYT/HSc+kpmoRs+NAgRRrh1MZbJ43dSPe2dS4wF2pZuvoQmE7hhEig3TLV3zOkfzAyLb1EY5yayKwIY/gpxTP3wkxh4Bm2AjORH89qUW4xA/LfE0NAh5QVbSZHt6oJ0NH+9li7Ck/jsOMvFxbY1SD7r6cKbh6bj9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPQ+n+vY; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ad2da2196bso815538eaf.3;
        Sun, 21 Apr 2024 21:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713758680; x=1714363480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9H203Nw0CSU+bl/koMHamR78hDvCazO1kH0pDFgFrg=;
        b=aPQ+n+vY/YEH3Ka2cPL5bB3+syy8RK4Le5igI7jyvTy6gpO8A/gnk29rrAYEDBc+Yh
         9dTkfMXwQ2jUmUvMN9bdnwW3oAy/3A09Ef3P78QVHlQBrBlqoxQ1RzQtzV1gL+2SfPWs
         g23AvZUeScymt/fi8gPLgY2OPcRvdmLBDP7fRHo0GCrOvVKy5b+suvfd/Ugu9idm7SdR
         wuoNzEkk7SWwOk/wor/EuLSahRKsWTE8qJ+Pht5DLQtm35WaQJ4VpGhdHUd/rErX1L1m
         SGkvZX864R1/jYeU3fzP4aBmAMfXpauoOQDji/uR7XClmGerTGhkQHgTsqGGL/4uKUbn
         wbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713758680; x=1714363480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9H203Nw0CSU+bl/koMHamR78hDvCazO1kH0pDFgFrg=;
        b=DBX27Ux0KfQUwXLdpSeigpgNpfeGxW2zovIUK6iTN2LnhaRhLayRIHKGTbp6AZZ+uv
         dlT/vJSHeFWB0IMlesYdyxjxfrp8wCwHkTboC5+zhq/lZr0bC6mSPh5KGrFpEeDHxGdu
         4AAY2dxUmESgh2JW662S98dhcHvlOgM2o1brq1K8lNqhvBtsj6vRaesDifCxp0FywPbq
         S+nyZOInIjcExgUJM0BnjDNuxvh2rbEQ1WXSY0Q8oofeRFV41jMA5YfrFFeGfbrDYRO4
         3XjFKQXwF7XgBlLQEGxRZ1GlZg2WYMxvqwY3EMvZqFdXMQjlp2lHer+uVBeB9m+bNDVD
         s2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWXEy1iVir+5vxfno2plVKoYqzyNw60QETVNvQv3nxVbcuHeE/XCBD7DYn2NHGE8hZA5HN4hWl8PHmgFZP19kLOOorrhEGgyuqDWQgS+LL23FIo8NaTBdyJ1FHn+NlJSqHd7isfdavK
X-Gm-Message-State: AOJu0YymUTp1d47xs+pGxlNlDR1UbDEveQsci7uwzDIOkf9yce+troQr
	17h7TscLCZH1VuZ0F6d93EoggE1kzJoAF3EFUJ4CTb3m5AhFxIOXwJLVgVJQWlReSRQ7Rwiiciy
	nHgn7Ltfj03XzalZSSQQo1DhUXMABe4cXMrVTSQ==
X-Google-Smtp-Source: AGHT+IHZY8b4LN4MZqAcxhBBHq46YFjyT6Due2pZBBrXe90rcm/IVYHIkZ2iUDLw0eSlbvjbL4YzEJTON0ZfPmlnhfw=
X-Received: by 2002:a4a:aa85:0:b0:5aa:4d6d:2674 with SMTP id
 d5-20020a4aaa85000000b005aa4d6d2674mr7919714oon.2.1713758680226; Sun, 21 Apr
 2024 21:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419105713.2427146-1-dzm91@hust.edu.cn> <ae157b64-67c2-422f-9025-86c3b9900f5e@gmail.com>
In-Reply-To: <ae157b64-67c2-422f-9025-86c3b9900f5e@gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Mon, 22 Apr 2024 12:04:13 +0800
Message-ID: <CAD-N9QXw80d33qN7bFHSa0MY+n5P-ZAuy+6eV5QyWXOX9Hr1_g@mail.gmail.com>
Subject: Re: [PATCH v3] docs/zh_CN: add process/cve Chinese translation
To: Alex Shi <seakeel@gmail.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gTW9uLCBBcHIgMjIsIDIwMjQgYXQgMTA6NTXigK9BTSBBbGV4IFNoaSA8c2Vha2VlbEBnbWFp
bC5jb20+IHdyb3RlOg0KPg0KPg0KPg0KPiBPbiA0LzE5LzI0IDY6NTYgUE0sIERvbmdsaWFuZyBN
dSB3cm90ZToNCj4gPiBUcmFuc2xhdGUgcHJvY2Vzcy9jdmUucnN0IGludG8gQ2hpbmVzZSBhbmQg
YWRkIGl0IHRvDQo+ID4gRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04gZGlyZWN0b3J5
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRG9uZ2xpYW5nIE11IDxkem05MUBodXN0LmVkdS5j
bj4NCj4gPiAtLS0NCj4gPiB2Mi0+djM6IHJlbW92ZSBhIHRyYWlsaW5nIHNwYWNlDQo+ID4gdjEt
PnYyOiBhZGQgYSBuZXdsaW5lIGF0IHRoZW4gZW5kIG9mIGN2ZS5yc3QuDQo+ID4gIC4uLi90cmFu
c2xhdGlvbnMvemhfQ04vcHJvY2Vzcy9jdmUucnN0ICAgICAgICB8IDg5ICsrKysrKysrKysrKysr
KysrKysNCj4gPiAgLi4uL3RyYW5zbGF0aW9ucy96aF9DTi9wcm9jZXNzL2luZGV4LnJzdCAgICAg
IHwgIDEgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDkwIGluc2VydGlvbnMoKykNCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3Byb2Nlc3Mv
Y3ZlLnJzdA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25z
L3poX0NOL3Byb2Nlc3MvY3ZlLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L3Byb2Nlc3MvY3ZlLnJzdA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAw
MDAwMDAwMDAwLi5iNGUyNWNkNTJhM2ENCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9j
dW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vzcy9jdmUucnN0DQo+ID4gQEAgLTAs
MCArMSw4OSBAQA0KPiA+ICsuLiBpbmNsdWRlOjogLi4vZGlzY2xhaW1lci16aF9DTi5yc3QNCj4g
PiArDQo+ID4gKzpPcmlnaW5hbDogRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2N2ZS5yc3QNCj4gPiAr
OlRyYW5zbGF0b3I6IERvbmdsaWFuZyBNdSA8ZHptOTFAaHVzdC5lZHUuY24+DQo+ID4gKw0KPiA+
ICs9PT09DQo+ID4gK0NWRXMNCj4gPiArPT09PQ0KPiA+ICsNCj4gPiArQ29tbW9uIFZ1bG5lcmFi
aWxpdGllcyBhbmQgRXhwb3N1cmUgKENWRcKuKSDnvJblj7fmmK/kuIDnp43mmI7noa7nmoTmlrnl
vI/mnaUNCj4gPiAr6K+G5Yir44CB5a6a5LmJ5ZKM55m76K6w5YWs5byA5oqr6Zyy55qE5a6J5YWo
5ryP5rSe44CC6ZqP552A5pe26Ze055qE5o6o56e777yM5a6D5Lus5Zyo5YaF5qC46aG555uu5Lit
55qE5a6e55So5oCnDQo+ID4gK+W3sue7j+S4i+mZje+8jENWRee8luWPt+e7j+W4uOS7peS4jemA
guW9k+eahOaWueW8j+WSjOS4jemAguW9k+eahOWOn+WboOiiq+WIhumFjeOAguWboOatpO+8jOWG
heaguOW8gOWPkeekvuWMug0KPiA+ICvlgL7lkJHkuo7pgb/lhY3kvb/nlKjlroPku6zjgILnhLbo
gIzvvIzliIbphY1DVkXkuI7lhbbku5blvaLlvI/nmoTlronlhajmoIfor4bnrKbnmoTmjIHnu63l
jovlipvvvIzku6Xlj4rlhoXmoLgNCj4gPiAr56S+5Yy65LmL5aSW55qE5Liq5Lq65ZKM5YWs5Y+4
55qE5oyB57ut5rul55So77yM5bey57uP5riF5qWa5Zyw6KGo5piO5YaF5qC456S+5Yy65bqU6K+l
5o6n5Yi26L+Z5LqbQ1ZF5YiG6YWN44CCDQo+ID4gKw0KPiA+ICtMaW51eOWGheaguOW8gOWPkeWb
oumYn+ehruWunuacieiDveWKm+S4uua9nOWcqOeahExpbnV45YaF5qC45a6J5YWo6Zeu6aKY5YiG
6YWNQ1ZF44CCQ1ZF55qE5YiG6YWNDQo+ID4gK+eLrOeri+S6jiA6ZG9jOmDlronlhajmvI/mtJ7m
iqXpgIHmtYHnqIs8L3Byb2Nlc3Mvc2VjdXJpdHktYnVncz5g44CCDQo+ID4gKw0KPiA+ICvmiYDm
nInliIbphY3nu5lMaW51eOWGheaguOeahENWReWIl+ihqOmDveWPr+S7peWcqGxpbnV4LWN2ZemC
ruS7tuWIl+ihqOeahOWtmOaho+S4reaJvuWIsO+8jOWmgg0KPiA+ICtodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1jdmUtYW5ub3VuY2UvIOaJgOekuuOAguWmguaenOaDs+iOt+W+l+W3suWI
humFjQ0KPiA+ICtDVkXnmoTpgJrnn6XvvIzor7figJzorqLpmIXigJ3or6Xpgq7ku7bliJfooajj
gILopoHojrflvpfliIbphY3nmoRDVkXpgJrnn6XvvIzor7forqLpmIXor6Xpgq7ku7bliJfooajv
vJoNCj4gPiArYHN1YnNjcmliZSA8aHR0cHM6Ly9zdWJzcGFjZS5rZXJuZWwub3JnL3N1YnNjcmli
aW5nLmh0bWw+YF/jgIINCj4NCj4gcy9zdWJzY3JpYmUv6K6i6ZiFLw0KPg0KPiA+ICsNCj4gPiAr
6L+H56iLDQo+ID4gKz09PT09PT0NCj4gPiArDQo+ID4gK+S9nOS4uuato+W4uOeos+WumuWPkeW4
g+i/h+eoi+eahOS4gOmDqOWIhu+8jOWPr+iDveWtmOWcqOWuieWFqOmXrumimOeahOWGheaguOab
tOaUueeUsei0n+i0o0NWRee8luWPt+WIhumFjQ0KPiA+ICvnmoTlvIDlj5HkurrlkZjor4bliKvv
vIzlubboh6rliqjkuLrlhbbliIbphY1DVkXnvJblj7fjgILov5nkuptDVkXliIbphY3kvJrkvZzk
uLrnu4/luLjmgKfnmoTpgJrlkYrnu4/luLgNCj4gPiAr5Y+R5biD5ZyobGludXgtY3ZlLWFubm91
bmNl6YKu5Lu25YiX6KGo5LiK44CCDQo+ID4gKw0KPiA+ICvms6jmhI/vvIznlLHkuo5MaW51eOWG
heaguOWcqOezu+e7n+S4reeahOeJueauiuWcsOS9je+8jOWHoOS5juS7u+S9lea8j+a0numDveWP
r+iDveiiq+WIqeeUqOadpeWNseWus+WGheaguA0KPiA+ICvnmoTlronlhajmgKfvvIzkvYbmmK/l
vZPmvI/mtJ7ooqvkv67lpI3lkI7vvIzliKnnlKjnmoTlj6/og73mgKfpgJrluLjkuI3mmI7mmL7j
gILlm6DmraTvvIxDVkXliIbphY3lm6LpmJ/ov4fkuo4NCj4gPiAr6LCo5oWO77yM5bm25bCGQ1ZF
57yW5Y+35YiG6YWN57uZ5LuW5Lus6K+G5Yir55qE5Lu75L2V5ryP5rSe5L+u5aSN44CC6L+Z5bCx
6Kej6YeK5LqG5Li65LuA5LmITGludXjlhoXmoLgNCj4gPiAr5Zui6Zif5Lya5Y+R5biD5aSn6YeP
55qEQ1ZF44CCDQo+ID4gKw0KPiA+ICvlpoLmnpxDVkXliIbphY3lm6LpmJ/plJnov4fkuobku7vk
vZXnlKjmiLforqTkuLrlupTor6XliIbphY1DVkXnmoTnibnlrprkv67lpI3vvIzor7flj5HpgIHn
lLXlrZDpgq7ku7bliLANCj4gPiArPGN2ZUBrZXJuZWwub3JnPu+8jOmCo+mHjOeahOWboumYn+Ww
huS4juaCqOS4gOi1t+W3peS9nOOAguivt+azqOaEj++8jOS7u+S9lea9nOWcqOeahOWuieWFqOmX
rumimA0KPiA+ICvkuI3lupTooqvlj5HpgIHliLDmraTpgq7nrrHvvIzlroPku4XnlKjkuo7kuLrl
t7Llj5HluIPnmoTlhoXmoLjmoJHkuK3nmoTmvI/mtJ7kv67lpI3liIbphY1DVkXjgILlpoLmnpzk
vaDop4nlvpcNCj4gPiAr6Ieq5bex5Y+R546w5LqG5LiA5Liq5pyq5L+u5aSN55qE5a6J5YWo6Zeu
6aKY77yM6K+35oyJ54WnIDpkb2M6YOWuieWFqOa8j+a0nuaKpemAgea1geeoiw0KPiA+ICs8L3By
b2Nlc3Mvc2VjdXJpdHktYnVncz5gIOWPkemAgeWIsExpbnV45YaF5qC456S+5Yy644CCDQo+ID4g
Kw0KPiA+ICtMaW51eOWGheaguOS4jeS8mue7meacquS/ruWkjeeahOWuieWFqOmXrumimOiHquWK
qOWIhumFjUNWRe+8m+WPquacieWcqOWuieWFqOS/ruWkjeWPr+eUqOS4lOW6lOeUqOS6jg0KPiA+
ICvnqLPlrprlhoXmoLjmoJHlkI7vvIxDVkXliIbphY3miY3kvJroh6rliqjlj5HnlJ/vvIzlubbk
uJTlroPlsIbpgJrov4flronlhajkv67lpI3nmoRHaXTmj5DkuqTnvJblj7fov5vooYwNCj4gPiAr
6Lef6Liq44CC5aaC5p6c5pyJ5Lq65biM5pyb5Zyo5o+Q5Lqk5a6J5YWo5L+u5aSN5LmL5YmN5YiG
6YWNQ1ZF77yM6K+36IGU57O75YaF5qC4Q1ZF5YiG6YWN5Zui6Zif77yM5LuODQo+ID4gK+S7luS7
rOeahOS4gOaJueS/neeVmee8luWPt+S4reiOt+W+l+ebuOW6lOeahENWRee8luWPt+OAgg0KPiA+
ICsNCj4gPiAr5a+55LqO55uu5YmN5rKh5pyJ5b6X5Yiw56iz5a6a5LiO6ZW/5pyf57u05oqk5YaF
5qC45Zui6Zif56ev5p6B5pSv5oyB55qE5YaF5qC454mI5pys5Lit5Y+R546w55qE5Lu75L2V6Zeu
6aKY77yMDQo+ID4gK+mDveS4jeS8muWIhumFjUNWRXPjgILlvZPliY3mlK/mjIHnmoTlhoXmoLjl
iIbmlK/liJfooajlj6/ku6XlnKggaHR0cHM6Ly9rZXJuZWwub3JnL3JlbGVhc2VzLmh0bWwNCj4g
PiAr5LiK5om+5Yiw44CCDQo+ID4gKw0KPiA+ICvooqvliIbphY1DVkXnmoTkuonorroNCj4gPiAr
PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+ICsNCj4gPiAr5a+55LqO5Li654m55a6a5YaF
5qC45L+u5pS55YiG6YWN55qEQ1ZF77yM5YW25LqJ6K665oiW5L+u5pS555qE5p2D6ZmQ5LuF5bGe
5LqO5Y+X5b2x5ZON5a2Q57O757uf55qE57u05oqk6ICF44CCDQo+ID4gK+i/meS4gOWOn+WImeeh
ruS/neS6hua8j+a0nuaKpeWRiueahOmrmOW6puWHhuehruaAp+WSjOWPr+mXrui0o+aAp+OAguWP
quaciemCo+S6m+WFt+aciea3seWOmuS4k+S4muefpeivhuWSjA0KPiA+ICvlr7nlrZDns7vnu5/m
t7HlhaXkuobop6PnmoTnu7TmiqTkurrlkZjvvIzmiY3og73mnInmlYjor4TkvLDlhoXmoLjmvI/m
tJ7nmoTmnInmlYjmgKflkozojIPlm7TvvIzlubbnoa7lrprlhbbpgILlvZPnmoQNCj4gPiArQ1ZF
5oyH5a6a562W55Wl44CC5Zyo5q2k5oyH5a6a5p2D6ZmQ5LmL5aSW77yM5Lu75L2V5LqJ6K665oiW
5L+u5pS5Q1ZF55qE5bCd6K+V6YO95Y+v6IO95a+86Ie05re35Lmx44CBDQo+ID4gK+S4jeWHhueh
rueahOaKpeWRiu+8jOW5tuacgOe7iOWNseWPiuezu+e7n+OAgg0KPiA+ICsNCj4gPiAr5peg5pWI
55qEQ1ZFDQo+ID4gKz09PT09PT09PT09PQ0KPiA+ICsNCj4gPiAr5aaC5p6c5Y+R546w55qE5a6J
5YWo6Zeu6aKY5a2Y5Zyo5LqO5LuF55Sx5p+QTGludXjlj5HooYzniYjmlK/mjIHnmoRMaW51eOWG
heaguOS4re+8jOWNs+WuieWFqOmXrumimOaYrw0KPiA+ICvnlLHkuo5MaW51eOWPkeihjOeJiOaJ
gOWBmueahOabtOaUueWvvOiHtO+8jOaIluiAhUxpbnV455qE5Y+R6KGM54mI5YaF5qC454mI5pys
5LiN5YaN5pivTGludXjlhoXmoLgNCj4gPiAr56S+5Yy65pSv5oyB55qE5YaF5qC454mI5pys77yM
6YKj5LmITGludXjlhoXmoLhDVkXlm6LpmJ/lsIbkuI3og73liIbphY1DVkXvvIzlv4Xpobvku45M
aW51eA0KPiA+ICvlj5HooYzniYjmnKzouqvor7fmsYLjgIINCj4gPiArDQo+ID4gK+WGheaguENW
ReWIhumFjeWboumYn+S7peWklueahOS7u+S9leWboumYn+WvuUxpbnV45YaF5qC45pSv5oyB54mI
5pys5YiG6YWN55qEQ1ZF6YO95LiN5bqU6KKrDQo+ID4gK+inhuS4uuacieaViENWReOAguivt+mA
muefpeWGheaguENWReWIhumFjeWboumYn++8jOS7peS+v+S7luS7rOWPr+S7pemAmui/h0NOQeS/
ruWkjei/h+eoi+S9vw0KPiA+ICvov5nkupvmnaHnm67lpLHmlYjjgIINCj4NCj4gIumAmui/h0NO
QeS/ruWkjei/h+eoi+S9v+i/meS6m+adoeebruWkseaViCIsIOi/memHjOeahOi/h+eoi+aYr+S4
jeaYr+WPr+S7peaNouaIkOWFtuS7luWQjeivjeabtOWlve+8nw0KPiDkvovlpoIn5o6q5pa9Jw0K
5Zev77yM5oSf6KeJ4oCc5o6q5pa94oCd6L+Z56eN5oSP6K+R6K+76LW35p2l5pu05aW95LiA5Lqb
44CC5LiA5Lya5Y+R6YCB5LiA5LiqIHY0DQo+ID4gKw0KPiA+ICvnibnlrppDVkXnmoTpgILnlKjm
gKcNCj4gPiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gKw0KPiA+ICvnlLHk
uo5MaW51eOWGheaguOWPr+S7peS7peiuuOWkmuS4jeWQjOaWueW8j+S9v+eUqO+8jOWklumDqOeU
qOaIt+WPr+S7pemAmui/h+iuuOWkmuS4jeWQjOaWueW8j+iuv+mXruWug++8jOaIluiAhQ0KPiA+
ICvmoLnmnKzmsqHmnInorr/pl67vvIzlm6DmraTku7vkvZXnibnlrppDVkXnmoTpgILnlKjmgKfl
j5blhrPkuo5MaW51eOeUqOaIt++8jOiAjOS4jeaYr+WGheaguENWReWIhumFjeWboumYn+OAgg0K
PiA+ICvor7fkuI3opoHkuI7miJHku6zogZTns7vmnaXlsJ3or5Xnoa7lrprku7vkvZXnibnlrppD
VkXnmoTpgILnlKjmgKfjgIINCj4gPiArDQo+ID4gK+atpOWklu+8jOeUseS6jua6kOS7o+eggeag
kemdnuW4uOWkp++8jOiAjOS7u+S9leS4gOS4quezu+e7n+mDveWPquS9v+eUqOa6kOS7o+eggeag
keeahOS4gOWwj+mDqOWIhu+8jOWboOatpOS7u+S9lQ0KPiA+ICtMaW51eOeUqOaIt+mDveW6lOiv
peaEj+ivhuWIsO+8jOWkp+mHj+WIhumFjeeahENWRXPkuI7ku5bku6znmoTns7vnu5/ml6DlhbPj
gIINCj4gPiArDQo+ID4gK+eugOiAjOiogOS5i++8jOaIkeS7rOS4jeefpemBk+aCqOeahOeUqOS+
i++8jOS5n+S4jeefpemBk+aCqOS9v+eUqOeahOaYr+WGheaguOeahOWTquS4qumDqOWIhu+8jOWb
oOatpOaIkeS7rOaXoOazlQ0KPiA+ICvnoa7lrprnibnlrprnmoRDVkXmmK/lkKbkuI7mgqjnmoTn
s7vnu5/nm7jlhbPjgIINCj4gPiArDQo+ID4gK+S4juW+gOW4uOS4gOagt++8jOacgOWlvemHh+WP
luaJgOacieWPkeW4g+eahOWGheaguOabtOaUue+8jOWboOS4uuWug+S7rOaYr+eUseiuuOWkmuek
vuWMuuaIkOWRmOWcqOS4gOS4que7n+S4gOeahA0KPiA+ICvmlbTkvZPkuK3kuIDotbfov5vooYzm
tYvor5XnmoTvvIzogIzkuI3mmK/kvZzkuLrkuKrliKvnmoTnsr7pgInmm7TmlLnjgILov5jopoHm
s6jmhI/vvIzlr7nkuo7orrjlpJrlronlhajpl67popjmnaUNCj4gPiAr6K+077yM5pW05L2T6Zeu
6aKY55qE6Kej5Yaz5pa55qGI5bm25LiN5piv5Zyo5Y2V5Liq5pu05pS55Lit5om+5Yiw55qE77yM
6ICM5piv5Zyo5b285q2k5LmL5LiK55qE6K645aSa5L+u5aSN55qE5oC7DQo+ID4gK+WSjOOAgueQ
huaDs+aDheWGteS4i++8jENWReWwhuiiq+WIhumFjee7meaJgOaciemXrumimOeahOaJgOacieS/
ruWkje+8jOS9huacieaXtuaIkeS7rOWwhuaXoOazleazqOaEj+WIsOS4gOS6mw0KPiA+ICvkv67l
pI3vvIzlm6DmraTmn5Dkupvkv67lpI3lj6/og73lnKjmsqHmnIlDVkXnmoTmg4XlhrXkuIvooqvp
h4flj5bjgIINCj4NCj4gcy/ph4flj5Yv6YeH55SoLw0KPg0KPiBmb3Igb3RoZXJzDQo+IFJldmll
d2VkLWJ5OiBBbGV4IFNoaSA8YWxleHNAa2VybmVsLm9yZz4NCj4NCj4gPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vzcy9pbmRleC5yc3QgYi9Eb2N1
bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9wcm9jZXNzL2luZGV4LnJzdA0KPiA+IGluZGV4
IDNjYTAyZDI4MWJlMC4uNWM2YzhjY2RkNTBkIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRp
b24vdHJhbnNsYXRpb25zL3poX0NOL3Byb2Nlc3MvaW5kZXgucnN0DQo+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vzcy9pbmRleC5yc3QNCj4gPiBAQCAtNDgs
NiArNDgsNyBAQCBUT0RPTElTVDoNCj4gPiAgICAgOm1heGRlcHRoOiAxDQo+ID4NCj4gPiAgICAg
ZW1iYXJnb2VkLWhhcmR3YXJlLWlzc3Vlcw0KPiA+ICsgICBjdmUNCj4gPg0KPiA+ICBUT0RPTElT
VDoNCj4gPg0KPg0K

